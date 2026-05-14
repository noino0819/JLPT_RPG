import { useMemo, useRef, useState } from "react";
import { Link } from "react-router-dom";
import { useDecksStore } from "../store/decksStore";
import { useAuthStore } from "../store/authStore";
import { useProfileStore } from "../store/profileStore";
import { parseCsv } from "../lib/csv";
import { playEnter } from "../lib/sfx";
import { showAlert, showConfirm } from "../store/modalStore";
import {
  MAX_DECK_NAME_LEN,
  MAX_ETYMOLOGY_LEN,
  MAX_HEADWORD_LEN,
  MAX_IMPORT_ROWS,
  MAX_MEANING_LEN,
  MAX_POS_LEN,
  MAX_READING_LEN,
  describeImportError,
  sanitizeSingleLine,
  sanitizeText,
  validateImportFile,
} from "../lib/validation";

export default function MyDeckPage() {
  const userId = useAuthStore((s) => s.userId);
  const decks = useDecksStore((s) => s.decks);
  const words = useDecksStore((s) => s.words);
  const createDeck = useDecksStore((s) => s.createDeck);
  const deleteDeck = useDecksStore((s) => s.deleteDeck);
  const addWord = useDecksStore((s) => s.addWord);
  const bulkAddWords = useDecksStore((s) => s.bulkAddWords);
  const deleteWord = useDecksStore((s) => s.deleteWord);

  const customDecks = useMemo(
    () => decks.filter((d) => !d.is_official),
    [decks],
  );
  const customDeckIds = useMemo(
    () => new Set(customDecks.map((d) => d.id)),
    [customDecks],
  );
  const customWords = useMemo(
    () => words.filter((w) => customDeckIds.has(w.deck_id)),
    [words, customDeckIds],
  );

  const [activeDeckId, setActiveDeckId] = useState<string | null>(
    customDecks[0]?.id ?? null,
  );
  const [newDeckName, setNewDeckName] = useState("");

  const handleCreate = async () => {
    const name = sanitizeSingleLine(newDeckName, MAX_DECK_NAME_LEN);
    if (!name) {
      await showAlert({
        title: "단어장 이름이 비어있어요",
        eyebrow: "デッキ名必須",
        message: "단어장 이름을 입력해 주세요.",
        tone: "warning",
      });
      return;
    }
    const deck = createDeck(name, undefined, userId ?? undefined);
    setActiveDeckId(deck.id);
    setNewDeckName("");
  };

  const activeDeck = customDecks.find((d) => d.id === activeDeckId) ?? null;
  const activeWords = customWords.filter((w) => w.deck_id === activeDeckId);

  return (
    <div className="space-y-5">
      <header>
        <h2 className="pixel-text font-pixel text-2xl text-parchment-100">
          📜 나만의 단어장
        </h2>
        <p className="mt-1 text-sm text-parchment-300">
          내 단어로 만든 던전. 외운 단어는 등급에 합산됩니다.
        </p>
      </header>

      <section className="panel space-y-2">
        <div className="font-pixel text-[10px] uppercase tracking-widest text-parchment-300">
          새 단어장 만들기
        </div>
        <div className="flex gap-2">
          <input
            value={newDeckName}
            onChange={(e) => setNewDeckName(e.target.value)}
            maxLength={MAX_DECK_NAME_LEN}
            placeholder="예: 회사에서 자주 쓰는 단어"
            className="flex-1 border-2 border-black bg-dungeon-50 px-3 py-2 text-parchment-100 outline-none focus:border-rune-500"
          />
          <button onClick={handleCreate} className="btn-primary">
            만들기
          </button>
        </div>
      </section>

      {customDecks.length === 0 ? (
        <div className="panel text-center text-parchment-300">
          아직 만든 단어장이 없어요.
        </div>
      ) : (
        <>
          <section className="flex flex-wrap gap-2">
            {customDecks.map((d) => (
              <button
                key={d.id}
                onClick={() => setActiveDeckId(d.id)}
                className={`border-2 px-3 py-2 font-pixel text-xs ${
                  d.id === activeDeckId
                    ? "border-rune-500 bg-rune-500/15 text-rune-400"
                    : "border-black bg-dungeon-100 text-parchment-100 hover:bg-dungeon-50"
                }`}
              >
                {d.name} ({customWords.filter((w) => w.deck_id === d.id).length})
              </button>
            ))}
          </section>

          {activeDeck && (
            <DeckEditor
              deckId={activeDeck.id}
              deckName={activeDeck.name}
              wordCount={activeWords.length}
              onAddWord={(w) => addWord(activeDeck.id, w)}
              onBulkAdd={(rows) => bulkAddWords(activeDeck.id, rows)}
              onDeleteDeck={async () => {
                const ok = await showConfirm({
                  title: "단어장 삭제",
                  eyebrow: "デッキ削除",
                  message: `"${activeDeck.name}" 단어장을 삭제할까요?\n이 단어장의 모든 단어가 사라집니다.`,
                  confirmLabel: "삭제",
                  cancelLabel: "취소",
                  tone: "danger",
                });
                if (ok) {
                  deleteDeck(activeDeck.id);
                  setActiveDeckId(null);
                }
              }}
              onDeleteWord={deleteWord}
              words={activeWords}
            />
          )}
        </>
      )}

      <Link to="/" className="btn-ghost w-full">
        ◀ 던전으로
      </Link>
    </div>
  );
}

interface DeckEditorProps {
  deckId: string;
  deckName: string;
  wordCount: number;
  words: ReturnType<typeof useDecksStore.getState>["words"];
  onAddWord: (w: {
    headword: string | null;
    reading: string;
    meaning: string;
    etymology?: string;
    part_of_speech?: string;
  }) => void;
  onBulkAdd: (
    rows: Array<{
      headword: string | null;
      reading: string;
      meaning: string;
      etymology?: string;
      part_of_speech?: string;
    }>,
  ) => number;
  onDeleteDeck: () => void;
  onDeleteWord: (id: string) => void;
}

function DeckEditor(props: DeckEditorProps) {
  const fileRef = useRef<HTMLInputElement>(null);
  const [importing, setImporting] = useState(false);
  const soundOn = useProfileStore((s) => s.settings.effects.sound);
  const [form, setForm] = useState({
    headword: "",
    reading: "",
    meaning: "",
    etymology: "",
    part_of_speech: "",
  });

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    const reading = sanitizeText(form.reading, MAX_READING_LEN);
    const meaning = sanitizeText(form.meaning, MAX_MEANING_LEN);
    if (!reading || !meaning) {
      await showAlert({
        title: "필수 항목이 비어있어요",
        eyebrow: "入力エラー",
        message: "읽기와 뜻은 반드시 입력해야 합니다.",
        tone: "warning",
      });
      return;
    }
    const headword = sanitizeText(form.headword, MAX_HEADWORD_LEN);
    const etymology = sanitizeText(form.etymology, MAX_ETYMOLOGY_LEN);
    const pos = sanitizeText(form.part_of_speech, MAX_POS_LEN);
    props.onAddWord({
      headword: headword || null,
      reading,
      meaning,
      etymology: etymology || undefined,
      part_of_speech: pos || undefined,
    });
    setForm({ headword: "", reading: "", meaning: "", etymology: "", part_of_speech: "" });
  };

  const handleFile = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;

    // 1차 가드: 파일 크기/형식
    const fileError = validateImportFile(file);
    if (fileError) {
      await showAlert({
        title: "파일을 가져올 수 없어요",
        eyebrow: "ファイル拒否",
        message: describeImportError(fileError),
        tone: "danger",
      });
      if (fileRef.current) fileRef.current.value = "";
      return;
    }

    setImporting(true);
    try {
      const name = file.name.toLowerCase();
      let rows;
      if (name.endsWith(".xlsx") || name.endsWith(".xls")) {
        // 엑셀 파서는 무거우므로 필요할 때만 동적 import
        const { parseExcel } = await import("../lib/excel");
        rows = await parseExcel(file);
      } else {
        rows = parseCsv(await file.text());
      }
      if (rows.length === 0) {
        await showAlert({
          title: "가져올 단어가 없어요",
          eyebrow: "インポート失敗",
          message:
            "가져올 수 있는 단어가 없습니다.\n컬럼 순서(한자 / 읽기 / 뜻 / 어원 / 품사)를 확인해 주세요.",
          tone: "warning",
        });
        return;
      }
      const truncated = rows.length >= MAX_IMPORT_ROWS;
      const added = props.onBulkAdd(rows);
      await showAlert({
        title: "불러오기 완료",
        eyebrow: "インポート完了",
        message: truncated
          ? `${added}개의 단어를 가져왔습니다.\n(한 번에 최대 ${MAX_IMPORT_ROWS}개까지만 가져올 수 있어 일부가 잘렸을 수 있어요.)`
          : `${added}개의 단어를 가져왔습니다.`,
        tone: "success",
      });
    } catch (err) {
      console.error("[bulk import]", err);
      await showAlert({
        title: "파일을 읽지 못했어요",
        eyebrow: "ファイル読込失敗",
        message:
          "파일을 읽지 못했습니다.\n.xlsx 또는 .csv 형식인지 확인해 주세요.",
        tone: "danger",
      });
    } finally {
      setImporting(false);
      if (fileRef.current) fileRef.current.value = "";
    }
  };

  const handleDownloadTemplate = async () => {
    try {
      const { downloadExcelTemplate } = await import("../lib/excel");
      await downloadExcelTemplate("단어장_예시.xlsx");
    } catch (err) {
      console.error("[template download]", err);
      await showAlert({
        title: "예시 파일 생성 실패",
        eyebrow: "テンプレ生成失敗",
        message: "예시 엑셀 파일을 만들지 못했습니다.\n잠시 후 다시 시도해 주세요.",
        tone: "danger",
      });
    }
  };

  return (
    <div className="space-y-4">
      <section className="panel">
        <div className="flex items-center justify-between">
          <div>
            <div className="pixel-text font-pixel text-lg text-parchment-100">
              {props.deckName}
            </div>
            <div className="text-xs text-parchment-300">
              {props.wordCount}개 단어
            </div>
          </div>
          <div className="flex gap-2">
            <Link
              to={`/study/deck/${props.deckId}`}
              onClick={() => {
                if (soundOn) playEnter();
              }}
              className="btn-primary"
            >
              ▶ 학습 시작
            </Link>
            <button onClick={props.onDeleteDeck} className="btn-danger">
              🗑
            </button>
          </div>
        </div>
      </section>

      <section className="panel space-y-3">
        <div className="flex items-center justify-between gap-2">
          <div className="font-pixel text-[10px] uppercase tracking-widest text-parchment-300">
            파일로 일괄 추가
          </div>
          <button
            type="button"
            onClick={handleDownloadTemplate}
            className="border-2 border-black bg-parchment-400 px-3 py-1 font-pixel text-[10px] text-parchment-900 hover:bg-parchment-300"
          >
            📥 엑셀 예시 다운로드
          </button>
        </div>
        <p className="text-xs text-parchment-300">
          엑셀(.xlsx) 또는 CSV(.csv) 지원 · 컬럼 순서:{" "}
          <code className="bg-dungeon-50 px-1">한자, 읽기, 뜻, 어원, 품사</code>
        </p>
        <p className="text-[11px] text-parchment-300/80">
          첫 줄에 헤더(예: "한자")가 있으면 자동으로 건너뜁니다. 한자 칸이 비어
          있으면 히라가나-only 단어로 저장돼요.
        </p>
        <input
          ref={fileRef}
          type="file"
          accept=".csv,.xlsx,.xls,text/csv,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
          onChange={handleFile}
          disabled={importing}
          className="block w-full border-2 border-black bg-dungeon-50 p-2 text-xs text-parchment-100 file:mr-3 file:border-0 file:bg-rune-500 file:px-3 file:py-1 file:font-pixel file:text-xs file:text-white disabled:opacity-60"
        />
        {importing && (
          <div className="font-pixel text-[10px] text-rune-400">
            파일 분석 중...
          </div>
        )}
      </section>

      <form onSubmit={handleSubmit} className="panel space-y-2">
        <div className="font-pixel text-[10px] uppercase tracking-widest text-parchment-300">
          단어 직접 추가
        </div>
        <div className="grid grid-cols-2 gap-2">
          <Input
            label="한자 (선택)"
            value={form.headword}
            onChange={(v) => setForm({ ...form, headword: v })}
            placeholder="首都"
            maxLength={MAX_HEADWORD_LEN}
          />
          <Input
            label="읽기 *"
            value={form.reading}
            onChange={(v) => setForm({ ...form, reading: v })}
            placeholder="しゅと"
            required
            maxLength={MAX_READING_LEN}
          />
          <Input
            label="뜻 *"
            value={form.meaning}
            onChange={(v) => setForm({ ...form, meaning: v })}
            placeholder="수도"
            required
            maxLength={MAX_MEANING_LEN}
          />
          <Input
            label="품사"
            value={form.part_of_speech}
            onChange={(v) => setForm({ ...form, part_of_speech: v })}
            placeholder="명사"
            maxLength={MAX_POS_LEN}
          />
        </div>
        <label className="block">
          <span className="font-pixel text-[10px] uppercase tracking-widest text-parchment-300">
            어원 (선택)
          </span>
          <textarea
            value={form.etymology}
            onChange={(e) => setForm({ ...form, etymology: e.target.value })}
            maxLength={MAX_ETYMOLOGY_LEN}
            className="mt-1 w-full border-2 border-black bg-dungeon-50 px-3 py-2 text-parchment-100 outline-none focus:border-rune-500"
            rows={2}
            placeholder="首(머리 수): ... / 都(도읍 도): ..."
          />
        </label>
        <button type="submit" className="btn-primary w-full">
          + 단어 추가
        </button>
      </form>

      {props.words.length > 0 && (
        <section className="panel">
          <div className="font-pixel text-[10px] uppercase tracking-widest text-parchment-300">
            단어 목록
          </div>
          <ul className="mt-2 divide-y-2 divide-black/30">
            {props.words.map((w) => (
              <li
                key={w.id}
                className="flex items-center justify-between py-2"
              >
                <div>
                  <div className="pixel-text-jp text-base text-parchment-100">
                    {w.headword ?? w.reading}
                  </div>
                  <div className="text-xs text-parchment-300">
                    {w.reading} · {w.meaning}
                  </div>
                </div>
                <button
                  onClick={() => props.onDeleteWord(w.id)}
                  className="border-2 border-black bg-dungeon-50 px-2 py-1 font-pixel text-[10px] text-volcano-400 hover:bg-volcano-500/20"
                >
                  삭제
                </button>
              </li>
            ))}
          </ul>
        </section>
      )}
    </div>
  );
}

function Input({
  label,
  value,
  onChange,
  placeholder,
  required,
  maxLength,
}: {
  label: string;
  value: string;
  onChange: (v: string) => void;
  placeholder?: string;
  required?: boolean;
  maxLength?: number;
}) {
  return (
    <label className="block">
      <span className="font-pixel text-[10px] uppercase tracking-widest text-parchment-300">
        {label}
      </span>
      <input
        value={value}
        onChange={(e) => onChange(e.target.value)}
        placeholder={placeholder}
        required={required}
        maxLength={maxLength}
        className="mt-1 w-full border-2 border-black bg-dungeon-50 px-3 py-2 text-parchment-100 outline-none focus:border-rune-500"
      />
    </label>
  );
}
