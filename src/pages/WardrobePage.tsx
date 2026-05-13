import { useState } from "react";
import PixelCharacter from "../components/PixelCharacter";
import PixelPet from "../components/PixelPet";
import { CHARACTER_LIST } from "../data/characters";
import {
  costumesForCharacter,
  type CostumeItem,
} from "../data/cosmetics";
import { PETS } from "../data/pets";
import { TITLES } from "../data/titles";
import { BADGES, MAX_EQUIPPED_BADGES } from "../data/badges";
import { FRAMES } from "../data/frames";
import { computeUnlocked, describeCondition } from "../lib/cosmetics";
import { useProfileStore } from "../store/profileStore";
import { useProgressStore } from "../store/progressStore";
import type {
  CharacterId,
  CosmeticBase,
  CosmeticKind,
} from "../types";

type Tab = "character" | "costume" | "pet" | "title" | "badge" | "frame";

const TABS: { id: Tab; icon: string; label: string }[] = [
  { id: "character", icon: "🧝", label: "캐릭터" },
  { id: "costume", icon: "👕", label: "코스튬" },
  { id: "pet", icon: "🐾", label: "펫" },
  { id: "title", icon: "📛", label: "칭호" },
  { id: "badge", icon: "🏅", label: "뱃지" },
  { id: "frame", icon: "🖼️", label: "액자" },
];

export default function WardrobePage() {
  // 처치 상태가 변하면 해금 상황도 변하므로 구독해서 리렌더 트리거
  useProgressStore((s) => s.byWord);
  const {
    selected_character,
    setCharacter,
    equipped,
    setCostume,
    setPet,
    setTitle,
    toggleBadge,
    setFrame,
  } = useProfileStore();

  // 매 렌더 시 재계산 — 카탈로그 크기가 작아 무시할 만한 비용.
  const { unlocked } = computeUnlocked();

  const [tab, setTab] = useState<Tab>("character");

  const currentCostume = equipped.costume[selected_character];

  return (
    <div className="space-y-4">
      <header>
        <h2 className="pixel-text font-pixel text-2xl text-parchment-100">
          🧝 캐릭터 / 옷장
        </h2>
        <p className="mt-1 text-sm text-parchment-300">
          외운 단어가 늘면 새로운 코스튬·펫·칭호가 해금돼요.
        </p>
      </header>

      {/* 미리보기: 현재 장착 상태를 한눈에 */}
      <section className="panel flex items-center gap-3">
        <div className="relative">
          <PixelCharacter
            id={selected_character}
            costumeId={currentCostume}
            size={80}
          />
          {equipped.pet && (
            <div className="absolute -bottom-1 -right-3">
              <PixelPet petId={equipped.pet} size={28} />
            </div>
          )}
        </div>
        <div className="min-w-0 flex-1">
          <EquippedSummary />
        </div>
      </section>

      {/* 탭 헤더 */}
      <div className="flex flex-wrap gap-1">
        {TABS.map((t) => (
          <button
            key={t.id}
            onClick={() => setTab(t.id)}
            className={`flex items-center gap-1 border-2 px-2 py-1 font-pixel text-xs ${
              tab === t.id
                ? "border-rune-500 bg-rune-500/15 text-rune-400"
                : "border-black bg-dungeon-50 text-parchment-200 hover:bg-dungeon-100"
            }`}
          >
            <span>{t.icon}</span>
            {t.label}
          </button>
        ))}
      </div>

      {/* 탭 컨텐츠 */}
      {tab === "character" && (
        <CharacterTab
          selected={selected_character}
          onPick={setCharacter}
          getCostume={(id) => equipped.costume[id]}
        />
      )}

      {tab === "costume" && (
        <CostumeTab
          characterId={selected_character}
          equippedId={currentCostume}
          unlocked={unlocked}
          onPick={(id) => setCostume(selected_character, id)}
        />
      )}

      {tab === "pet" && (
        <ItemGrid
          items={PETS}
          unlocked={unlocked}
          equippedId={equipped.pet}
          onPick={(id) => setPet(equipped.pet === id ? null : id)}
          renderPreview={(item) => <PixelPet petId={item.id} size={40} />}
        />
      )}

      {tab === "title" && (
        <ItemGrid
          items={TITLES}
          unlocked={unlocked}
          equippedId={equipped.title}
          onPick={(id) => setTitle(equipped.title === id ? null : id)}
          renderPreview={(item) => {
            const t = TITLES.find((x) => x.id === item.id)!;
            return (
              <div
                className={`px-2 py-1 font-pixel text-[10px] ${t.color}`}
              >
                {t.textJp}
              </div>
            );
          }}
        />
      )}

      {tab === "badge" && (
        <>
          <p className="text-xs text-parchment-300">
            최대 {MAX_EQUIPPED_BADGES}개까지 동시 장착할 수 있어요.
          </p>
          <ItemGrid
            items={BADGES}
            unlocked={unlocked}
            equippedIds={equipped.badges}
            onPick={(id) => toggleBadge(id)}
            renderPreview={(item) => {
              const b = BADGES.find((x) => x.id === item.id)!;
              return (
                <div className={`badge-pixel ${b.tone}`}>
                  <span className="text-base">{b.icon}</span>
                </div>
              );
            }}
          />
        </>
      )}

      {tab === "frame" && (
        <ItemGrid
          items={FRAMES}
          unlocked={unlocked}
          equippedId={equipped.frame}
          onPick={(id) => setFrame(equipped.frame === id ? null : id)}
          renderPreview={(item) => {
            const f = FRAMES.find((x) => x.id === item.id)!;
            return (
              <div className={`grid h-12 w-12 place-items-center ${f.className}`}>
                <PixelCharacter
                  id={selected_character}
                  costumeId={currentCostume}
                  size={36}
                />
              </div>
            );
          }}
        />
      )}
    </div>
  );
}

// ───────── 장착 요약 ─────────

function EquippedSummary() {
  const { equipped } = useProfileStore();
  const title = equipped.title
    ? TITLES.find((t) => t.id === equipped.title)
    : null;
  const frame = equipped.frame
    ? FRAMES.find((f) => f.id === equipped.frame)
    : null;
  const pet = equipped.pet ? PETS.find((p) => p.id === equipped.pet) : null;
  const badges = equipped.badges
    .map((id) => BADGES.find((b) => b.id === id))
    .filter(Boolean);

  return (
    <div className="space-y-1">
      <div className="font-pixel text-[10px] uppercase tracking-widest text-parchment-300">
        현재 장착
      </div>
      {title ? (
        <div className={`font-pixel text-sm ${title.color}`}>
          {title.textJp} · {title.textKo}
        </div>
      ) : (
        <div className="font-pixel text-xs text-parchment-300">
          칭호 없음
        </div>
      )}
      <div className="flex flex-wrap items-center gap-1 text-[10px] text-parchment-200">
        <span>액자: {frame?.nameJp ?? "기본"}</span>
        <span>· 펫: {pet?.nameJp ?? "없음"}</span>
      </div>
      {badges.length > 0 && (
        <div className="flex flex-wrap gap-1">
          {badges.map((b) =>
            b ? (
              <span key={b.id} className={`badge-pixel ${b.tone}`}>
                {b.icon}
              </span>
            ) : null,
          )}
        </div>
      )}
    </div>
  );
}

// ───────── 캐릭터 선택 탭 ─────────

function CharacterTab({
  selected,
  onPick,
  getCostume,
}: {
  selected: CharacterId;
  onPick: (id: CharacterId) => void;
  getCostume: (id: CharacterId) => string;
}) {
  return (
    <section className="grid grid-cols-2 gap-3 sm:grid-cols-4">
      {CHARACTER_LIST.map((c) => {
        const active = c.id === selected;
        return (
          <button
            key={c.id}
            onClick={() => onPick(c.id)}
            className={`flex flex-col items-center gap-2 border-2 px-3 py-4 transition ${
              active
                ? "border-rune-500 bg-rune-500/15"
                : "border-black bg-dungeon-100 hover:bg-dungeon-50"
            }`}
          >
            <PixelCharacter
              id={c.id}
              costumeId={getCostume(c.id)}
              size={56}
            />
            <div className="font-pixel text-xs text-parchment-100">
              {c.nameJp}
            </div>
            <div className="text-[10px] text-parchment-300">{c.name}</div>
          </button>
        );
      })}
    </section>
  );
}

// ───────── 코스튬 탭 (캐릭터별로 필터) ─────────

function CostumeTab({
  characterId,
  equippedId,
  unlocked,
  onPick,
}: {
  characterId: CharacterId;
  equippedId: string;
  unlocked: Set<string>;
  onPick: (id: string) => void;
}) {
  const items: CostumeItem[] = costumesForCharacter(characterId);
  return (
    <section className="grid grid-cols-2 gap-3 sm:grid-cols-3">
      {items.map((item) => {
        const isUnlocked = unlocked.has(item.id);
        const equipped = item.id === equippedId;
        return (
          <CardButton
            key={item.id}
            disabled={!isUnlocked}
            onClick={() => isUnlocked && onPick(item.id)}
            equipped={equipped}
            unlocked={isUnlocked}
            item={item}
            preview={
              <PixelCharacter
                id={characterId}
                costumeId={item.id}
                size={56}
              />
            }
          />
        );
      })}
    </section>
  );
}

// ───────── 일반 그리드 (펫/칭호/뱃지/프레임) ─────────

interface ItemGridProps<T extends CosmeticBase> {
  items: T[];
  unlocked: Set<string>;
  equippedId?: string | null;
  equippedIds?: string[];
  onPick: (id: string) => void;
  renderPreview: (item: T) => React.ReactNode;
}

function ItemGrid<T extends CosmeticBase>({
  items,
  unlocked,
  equippedId,
  equippedIds,
  onPick,
  renderPreview,
}: ItemGridProps<T>) {
  return (
    <section className="grid grid-cols-2 gap-3 sm:grid-cols-3">
      {items.map((item) => {
        const isUnlocked = unlocked.has(item.id);
        const equipped =
          equippedIds !== undefined
            ? equippedIds.includes(item.id)
            : item.id === equippedId;
        return (
          <CardButton
            key={item.id}
            disabled={!isUnlocked}
            onClick={() => isUnlocked && onPick(item.id)}
            equipped={equipped}
            unlocked={isUnlocked}
            item={item}
            preview={renderPreview(item)}
          />
        );
      })}
    </section>
  );
}

// ───────── 공통 카드 ─────────

function CardButton({
  disabled,
  onClick,
  equipped,
  unlocked,
  item,
  preview,
}: {
  disabled: boolean;
  onClick: () => void;
  equipped: boolean;
  unlocked: boolean;
  item: CosmeticBase;
  preview: React.ReactNode;
}) {
  return (
    <button
      type="button"
      disabled={disabled}
      onClick={onClick}
      className={`relative flex flex-col items-center gap-2 border-2 px-3 py-3 text-center transition ${
        equipped
          ? "border-rune-500 bg-rune-500/15"
          : unlocked
            ? "border-black bg-dungeon-100 hover:bg-dungeon-50"
            : "border-black/60 bg-dungeon-200/50 opacity-70"
      }`}
    >
      <div
        className={`grid h-16 w-16 place-items-center ${unlocked ? "" : "grayscale"}`}
      >
        {preview}
      </div>
      <div className="font-pixel text-[11px] text-parchment-100">
        {item.nameJp ?? item.name}
      </div>
      <div className="text-[10px] text-parchment-300">{item.name}</div>

      {!unlocked && (
        <div className="font-pixel text-[10px] text-volcano-400">
          🔒 {describeCondition(item.condition)}
        </div>
      )}
      {unlocked && equipped && (
        <div className="absolute right-1 top-1 border border-black bg-rune-500 px-1 font-pixel text-[10px] text-black">
          장착
        </div>
      )}
      {unlocked && !equipped && item.kind !== "costume" && (
        <KindHint kind={item.kind} />
      )}
    </button>
  );
}

function KindHint({ kind }: { kind: CosmeticKind }) {
  if (kind === "badge") {
    return (
      <div className="font-pixel text-[10px] text-parchment-300">
        탭하여 토글
      </div>
    );
  }
  return null;
}
