import { create } from "zustand";
import { persist } from "zustand/middleware";
import {
  DEFAULT_EQUIPPED,
  DEFAULT_SETTINGS,
  type CharacterId,
  type EquippedCosmetics,
  type Settings,
} from "../types";
import { MAX_EQUIPPED_BADGES } from "../data/badges";

interface ProfileState {
  nickname: string;
  selected_character: CharacterId;
  settings: Settings;
  equipped: EquippedCosmetics;
  setNickname: (nickname: string) => void;
  setCharacter: (id: CharacterId) => void;
  updateSettings: (patch: Partial<Settings>) => void;
  toggleEffect: (key: keyof Settings["effects"]) => void;
  setCostume: (characterId: CharacterId, costumeId: string) => void;
  setPet: (petId: string | null) => void;
  setTitle: (titleId: string | null) => void;
  toggleBadge: (badgeId: string) => void;
  setFrame: (frameId: string | null) => void;
  reset: () => void;
}

export const useProfileStore = create<ProfileState>()(
  persist(
    (set) => ({
      nickname: "見習い",
      selected_character: "warrior",
      settings: DEFAULT_SETTINGS,
      equipped: DEFAULT_EQUIPPED,
      setNickname: (nickname) => set({ nickname }),
      setCharacter: (id) => set({ selected_character: id }),
      updateSettings: (patch) =>
        set((s) => ({ settings: { ...s.settings, ...patch } })),
      toggleEffect: (key) =>
        set((s) => ({
          settings: {
            ...s.settings,
            effects: { ...s.settings.effects, [key]: !s.settings.effects[key] },
          },
        })),
      setCostume: (characterId, costumeId) =>
        set((s) => ({
          equipped: {
            ...s.equipped,
            costume: { ...s.equipped.costume, [characterId]: costumeId },
          },
        })),
      setPet: (petId) =>
        set((s) => ({ equipped: { ...s.equipped, pet: petId } })),
      setTitle: (titleId) =>
        set((s) => ({ equipped: { ...s.equipped, title: titleId } })),
      toggleBadge: (badgeId) =>
        set((s) => {
          const list = s.equipped.badges;
          if (list.includes(badgeId)) {
            return {
              equipped: {
                ...s.equipped,
                badges: list.filter((b) => b !== badgeId),
              },
            };
          }
          // 최대 개수 초과 시 가장 오래된 것을 제거
          const next =
            list.length >= MAX_EQUIPPED_BADGES
              ? [...list.slice(1), badgeId]
              : [...list, badgeId];
          return { equipped: { ...s.equipped, badges: next } };
        }),
      setFrame: (frameId) =>
        set((s) => ({ equipped: { ...s.equipped, frame: frameId } })),
      reset: () =>
        set({
          nickname: "見習い",
          selected_character: "warrior",
          settings: DEFAULT_SETTINGS,
          equipped: DEFAULT_EQUIPPED,
        }),
    }),
    {
      name: "jlpt-rpg-profile",
      // 새로운 설정 키가 추가될 때 기존 영속화 데이터에 기본값을 보충
      merge: (persisted, current) => {
        const p = (persisted as Partial<ProfileState>) ?? {};
        return {
          ...current,
          ...p,
          settings: {
            ...DEFAULT_SETTINGS,
            ...(p.settings ?? {}),
            effects: {
              ...DEFAULT_SETTINGS.effects,
              ...(p.settings?.effects ?? {}),
            },
          },
          equipped: {
            ...DEFAULT_EQUIPPED,
            ...(p.equipped ?? {}),
            costume: {
              ...DEFAULT_EQUIPPED.costume,
              ...(p.equipped?.costume ?? {}),
            },
            badges: p.equipped?.badges ?? DEFAULT_EQUIPPED.badges,
          },
        } as ProfileState;
      },
    },
  ),
);
