# AI Documentation & Roadmap

This folder contains documentation, prompts, and roadmap details for the AI assistant to follow during the development of **Idle Laboratory**.

---

## ✅ Implemented Features (Completed)

### 1. Energy & Production System
- **EU Generation**: Real-time energy generation based on active cells and production stock.
- **Scientific Notation**: Toggleable display for large numbers to keep the UI clean.
- **Auto-Save**: Periodic persistence of energy and production state.

### 2. Energy Cells System
- **Cell Tiers**: 16 unique energy cells (Basic, Heat, Ice, etc.) with progressive unlock requirements.
- **Leveling**: Cells can be leveled up to increase their base Energy Per Second (EPS).
- **Production**: Automated cell generation with upgradeable acceleration levels.
- **Visuals**: Animated battery-style graphics reflecting the "fill level" and energy activity.

### 3. Crafting & Merging Logic
- **Base Tier Crafting**: Ability to consume energy cells to create Tier 1 research materials.
- **Reagent Merging**: A merge system where two materials can be combined to create a higher-tier material based on the research tree hierarchy.
- **Reaction Process**: Visual progress bar, energy costs, and timed reactions (currently 5s for testing).
- **Auto-Cleanup**: Input and output slots automatically clear upon successful reaction completion.

### 4. Research Tree
- **Binary Hierarchy**: A visual 31-node pyramid representing the path from base materials to the ultimate endgame item.
- **Interactive Nodes**: Tapping any node opens a detailed dialog with material descriptions and crafting requirements.
- **Visual Conduits**: Dynamic lines connecting materials to show merge paths.

### 5. Storage & Inventory
- **Material Grid**: A dedicated tab showing all 31 materials with current stock counts.
- **Persistence**: Full local storage saving for all crafted materials.
- **Badge Notifications**: Animated "+1" popups on the Storage tab when a craft finishes, visible from any sub-tab.

### 6. Prestige System
- **Reset Mechanic**: Ability to reset progress in exchange for a permanent EPS multiplier.
- **Thresholds**: Progressive requirements to trigger the next prestige level.

### 7. Advanced Crafting System (Bulk Crafting)
- **Quantity Input**: A specialized text field to specify exactly how many materials to craft.
- **"Pay-as-you-go" Logic**: Materials and energy are deducted per unit produced, ensuring no resources are lost if a reaction is stopped early.
- **Queue Management**: Real-time decrementing counter showing remaining items in the queue.
- **Manual Stop**: Ability to cancel an ongoing bulk reaction at any time.
- **Reactive Validation**: The interface automatically enables/disables based on real-time resource generation.
- **Enhanced UX**: Dynamic cost updates and smarter sidebar animations that follow the player across different menu sections.

### 8. Tablet/Desktop Layout
- **Remove ScreenUtil**: Transitioned away from `flutter_screenutil` to a more manual, BLoC-driven layout system.
- **Responsive Adjustments**: Used `AppLayoutBloc` to fine-tune UI elements for mobile, tablet, and desktop.
- **Adaptive Components**: Ensured all widgets (buttons, text fields, modals) look natural across all screen sizes.
- **Unified Border System**: Created `AppBorderContainer` and `AppDivider` for consistent responsive styling.

### 9. Onboarding & Tutorial System
- **Tutorial Overlay**: Spotlight via `tutorial_coach_mark`.
- **Lore Integration**: Magician character guides the player through tabs (kind / greedy sprites).
- **Trigger Logic**: Auto-start on first app entry; tab tutorials on navigation.
- **Prologue**: Kind-magician intro (2 pages) before coach marks; Bloodstone framed as hope. Currently replays every launch for testing.
- **Manual restart**: Still planned in Overview (see Future §1).

---

## 🚀 Future Roadmap (TODOs)

### 1. Overview Section Enhancements
- [ ] **Game Lore**: Add a short, engaging explanation of the game's world and the player's role.
- [ ] **Tutorial Access**: Add a prominent "Replay Tutorial" button.

### 2. Statistics Tab
- [ ] **Data Tracking**: Implement tracking for:
    - Total play time.
    - Lifetime energy farmed.
    - Lifetime count of each cell type farmed.
    - Lifetime count of each material type crafted.
- [ ] **UI**: Create a clean, scrollable list of these stats.

### 3. Settings Tab
- [ ] **Configuration**: Placeholder for future settings (Audio, Notifications, Account management, etc.).

### 4. Achievements System
- [ ] **Platform Integration**: Research and plan for Google Play Games Services and Apple Game Center integration.
- [ ] **Achievement List**:
    - Reach `n` total energy.
    - Reach `n` energy per second (EPS).
    - Craft first of each cell/material type.
    - Craft `n` total amount of a specific material.
    - Complete tutorial.
    - Watch final lore cutscene.

### 5. Endgame & Final Lore (in progress)
- [x] **Victory Condition**: Trigger ending when Bloodstone of Dominion is crafted.
- [x] **Evil reveal**: Magician (`magician_evil`) confesses true intent after the craft.
- [x] **Epilogue**: "To Be Continued" screen after the reveal.
- [x] **Prologue**: Kind-magician welcome + Bloodstone-as-hope pitch (before tutorial).
- [ ] **Persist prologue/tutorial seen flags** (stop replaying every launch once polish is done).
- [ ] **Opening / mid-game story beats** (see ideas below).
- [ ] Overview lore blurb + persistent “ultimate goal” reminder.

#### Mid-game story beat ideas (next)
1. **First craft success** — short kind-magician toast/dialog: praise + soft Bloodstone reminder (“another step toward the summit”).
2. **First prestige** — greedy edge slips in: “Sacrifice what you built… for a greater good.” Foreshadows the twist without spoiling.
3. **Research tree mid-tier** (e.g. first Tier-3 / half pyramid) — brief cut-in: magician grows impatient / hungry for the stone “so the world can heal sooner.”
4. **Parents of Bloodstone unlocked** — last calm kind beat, then colder greed: “We are so close. Do not falter.”
5. **Persistent goal UI** — Overview (and/or Research header): “Quest: Craft the Bloodstone of Dominion” with one-line lore, so players never lose the north star between sessions.
6. **Optional idle return** — rare offline dialog: magician “checking on progress” (kind early, greedier late-game).

### 6. Game Balance & Polish
- [ ] **Material-Specific Metrics**: Move away from test values (5s/5EU) to unique craft timers and costs for each material.
- [ ] **Button States**: Refine visual feedback for all button states (hover, pressed, disabled).
- [ ] **General UI/UX**: Continuous improvements to the "gaming" aesthetic across all tabs.

### 7. Monetization & Support
- [ ] **"Buy Me a Coffee"**: Add a simple, non-intrusive donation button (e.g., in Settings or Overview) for players who want to support the developer.
- [ ] **Platform Integration**: Use `url_launcher` or similar to redirect to a support page (PayPal, Ko-fi, etc.).

### 8. Offline Progress
- [ ] **Time Tracking**: Calculate the duration the user was away from the app.
- [ ] **Reward Calculation**: Grant energy, cells, and production progress based on offline time.
- [ ] **Constraints**: Implement a cap on offline progress (e.g., maximum 15 minutes) to encourage regular check-ins.
- [ ] **UI**: Show a summary dialog upon re-entering the app detailing the gains made while away.
