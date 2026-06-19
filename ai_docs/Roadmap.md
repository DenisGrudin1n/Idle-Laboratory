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

---

## 🚀 Future Roadmap (TODOs)

### 1. Onboarding & Tutorial System
- [ ] **Tutorial Overlay**: Implement a "spotlight" effect where the screen darkens, leaving only specific features bright and interactive.
- [ ] **Lore Integration**: Introduce the "Evil Mage" character as the central figure of the tutorial.
- [ ] **Trigger Logic**: 
    - Auto-start on first app entry.
    - Manual restart button in the **Overview** section.
- [ ] **Potential Solutions**: Research packages like `tutorial_coach_mark` or `showcaseview` for smooth animations and spotlighting.

### 2. Overview Section Enhancements
- [ ] **Game Lore**: Add a short, engaging explanation of the game's world and the player's role.
- [ ] **Tutorial Access**: Add a prominent "Replay Tutorial" button.

### 3. Statistics Tab
- [ ] **Data Tracking**: Implement tracking for:
    - Total play time.
    - Lifetime energy farmed.
    - Lifetime count of each cell type farmed.
    - Lifetime count of each material type crafted.
- [ ] **UI**: Create a clean, scrollable list of these stats.

### 4. Settings Tab
- [ ] **Configuration**: Placeholder for future settings (Audio, Notifications, Account management, etc.).

### 5. Achievements System
- [ ] **Platform Integration**: Research and plan for Google Play Games Services and Apple Game Center integration.
- [ ] **Achievement List**:
    - Reach `n` total energy.
    - Reach `n` energy per second (EPS).
    - Craft first of each cell/material type.
    - Craft `n` total amount of a specific material.
    - Complete tutorial.
    - Watch final lore cutscene.

### 6. Endgame & Final Lore
- [ ] **Victory Condition**: Trigger final lore/cutscene when the absolute top-tier material is crafted.
- [ ] **Cutscene System**: Implement a way to display narrative-heavy endgame content.

### 7. Game Balance & Polish
- [ ] **Material-Specific Metrics**: Move away from test values (5s/5EU) to unique craft timers and costs for each material.
- [ ] **Button States**: Refine visual feedback for all button states (hover, pressed, disabled).
- [ ] **General UI/UX**: Continuous improvements to the "gaming" aesthetic across all tabs.

### 8. Monetization & Support
- [ ] **"Buy Me a Coffee"**: Add a simple, non-intrusive donation button (e.g., in Settings or Overview) for players who want to support the developer.
- [ ] **Platform Integration**: Use `url_launcher` or similar to redirect to a support page (PayPal, Ko-fi, etc.).
