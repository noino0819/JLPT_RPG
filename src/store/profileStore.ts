import { create } from "zustand";
import { persist } from "zustand/middleware";
import {
  DEFAULT_SETTINGS,
  type CharacterId,
  type Settings,
} from "../types";

interface ProfileState {
  nickname: string;
  selected_character: CharacterId;
  settings: Settings;
  setNickname: (nickname: string) => void;
  setCharacter: (id: CharacterId) => void;
  updateSettings: (patch: Partial<Settings>) => void;
  toggleEffect: (key: keyof Settings["effects"]) => void;
  reset: () => void;
}

export const useProfileStore = create<ProfileState>()(
  persist(
    (set) => ({
      nickname: "見習い",
      selected_character: "warrior",
      settings: DEFAULT_SETTINGS,
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
      reset: () =>
        set({
          nickname: "見習い",
          selected_character: "warrior",
          settings: DEFAULT_SETTINGS,
        }),
    }),
    { name: "jlpt-rpg-profile" },
  ),
);
