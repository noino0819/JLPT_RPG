import { useRef, useState } from "react";
import { Link } from "react-router-dom";
import { useDecksStore } from "../store/decksStore";
import { parseCsv } from "../lib/csv";

export default function MyDeckPage() {
  const {
    customDecks,
    customWords,
    createDeck,
    deleteDeck,
    addWord,
    bulkAddWords,
    deleteWord,
  } = useDecksStore();

  const [activeDeckId, setActiveDeckId] = useState<string | null>(
    customDecks[0]?.id ?? null,
  );
  const [newDeckName, setNewDeckName] = useState("");

  const handleCreate = () => {
    if (!newDeckName.trim()) return;
    const deck = createDeck(newDeckName.trim());
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
              onDeleteDeck={() => {
                if (
                  confirm(
                    `"${activeDeck.name}" 단어장을 삭제할까요? 이 단어장의 모든 단어가 사라집니다.`,
                  )
                ) {
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
  words: ReturnType<typeof useDecksStore.getState>["customWords"];
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
  const [form, setForm] = useState({
    headword: "",
    reading: "",
    meaning: "",
    etymology: "",
    part_of_speech: "",
  });

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (!form.reading || !form.meaning) return;
    props.onAddWord({
      headword: form.headword || null,
      reading: form.reading,
      meaning: form.meaning,
      etymology: form.etymology || undefined,
      part_of_speech: form.part_of_speech || undefined,
    });
    setForm({ headword: "", reading: "", meaning: "", etymology: "", part_of_speech: "" });
  };

  const handleCsv = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;
    const text = await file.text();
    const rows = parseCsv(text);
    const added = props.onBulkAdd(rows);
    alert(`${added}개의 단어를 가져왔습니다.`);
    if (fileRef.current) fileRef.current.value = "";
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
        <div className="font-pixel text-[10px] uppercase tracking-widest text-parchment-300">
          CSV 업로드
        </div>
        <p className="text-xs text-parchment-300">
          포맷: <code className="bg-dungeon-50 px-1">한자, 읽기, 뜻, 어원, 품사</code> · 첫 줄에 "한자" 헤더 포함 가능
        </p>
        <input
          ref={fileRef}
          type="file"
          accept=".csv,text/csv"
          onChange={handleCsv}
          className="block w-full border-2 border-black bg-dungeon-50 p-2 text-xs text-parchment-100 file:mr-3 file:border-0 file:bg-rune-500 file:px-3 file:py-1 file:font-pixel file:text-xs file:text-white"
        />
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
          />
          <Input
            label="읽기 *"
            value={form.reading}
            onChange={(v) => setForm({ ...form, reading: v })}
            placeholder="しゅと"
            required
          />
          <Input
            label="뜻 *"
            value={form.meaning}
            onChange={(v) => setForm({ ...form, meaning: v })}
            placeholder="수도"
            required
          />
          <Input
            label="품사"
            value={form.part_of_speech}
            onChange={(v) => setForm({ ...form, part_of_speech: v })}
            placeholder="명사"
          />
        </div>
        <label className="block">
          <span className="font-pixel text-[10px] uppercase tracking-widest text-parchment-300">
            어원 (선택)
          </span>
          <textarea
            value={form.etymology}
            onChange={(e) => setForm({ ...form, etymology: e.target.value })}
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
}: {
  label: string;
  value: string;
  onChange: (v: string) => void;
  placeholder?: string;
  required?: boolean;
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
        className="mt-1 w-full border-2 border-black bg-dungeon-50 px-3 py-2 text-parchment-100 outline-none focus:border-rune-500"
      />
    </label>
  );
}
