import { useNavigate } from "react-router-dom";
import { CHARACTER_LIST, CHARACTERS } from "../data/characters";
import PixelCharacter from "../components/PixelCharacter";
import { useProfileStore } from "../store/profileStore";
import type { CharacterId } from "../types";

export default function CharacterPage() {
  const navigate = useNavigate();
  const { selected_character, setCharacter } = useProfileStore();

  const handlePick = (id: CharacterId) => {
    setCharacter(id);
  };

  const meta = CHARACTERS[selected_character];

  return (
    <div className="space-y-5">
      <header>
        <h2 className="pixel-text font-pixel text-2xl text-parchment-100">
          🧝 캐릭터 선택
        </h2>
        <p className="mt-1 text-sm text-parchment-300">
          선택한 캐릭터에 따라 공격 이펙트가 달라져요. 학습 중에도 언제든 변경
          가능합니다.
        </p>
      </header>

      <section className="panel flex items-center justify-between">
        <div>
          <div className="font-pixel text-[10px] uppercase tracking-widest text-parchment-300">
            현재 캐릭터
          </div>
          <div className="pixel-text font-pixel text-xl text-parchment-100">
            {meta.nameJp} · {meta.name}
          </div>
          <div className={`text-sm ${meta.effectColor}`}>
            특수 이펙트: {effectName(meta.effect)}
          </div>
        </div>
        <PixelCharacter id={selected_character} size={88} />
      </section>

      <section className="grid grid-cols-2 gap-3 sm:grid-cols-4">
        {CHARACTER_LIST.map((c) => {
          const active = c.id === selected_character;
          return (
            <button
              key={c.id}
              onClick={() => handlePick(c.id)}
              className={`flex flex-col items-center gap-2 border-2 px-3 py-4 transition ${
                active
                  ? "border-rune-500 bg-rune-500/15"
                  : "border-black bg-dungeon-100 hover:bg-dungeon-50"
              }`}
            >
              <PixelCharacter id={c.id} size={56} />
              <div className="font-pixel text-xs text-parchment-100">
                {c.nameJp}
              </div>
              <div className="text-[10px] text-parchment-300">{c.name}</div>
              <div className={`text-[10px] ${c.effectColor}`}>
                {effectName(c.effect)}
              </div>
            </button>
          );
        })}
      </section>

      <button onClick={() => navigate("/")} className="btn-primary w-full">
        ▶ 던전으로 출발
      </button>
    </div>
  );
}

function effectName(e: string) {
  switch (e) {
    case "slash":
      return "대각선 슬래시";
    case "particles":
      return "파티클 폭발";
    case "arrow":
      return "화살 트레일";
    case "ring":
      return "확장 링";
    default:
      return e;
  }
}
