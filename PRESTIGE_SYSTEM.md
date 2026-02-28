# Prestige System

## Overview

The prestige system allows players to reset their progress in exchange for a permanent EPS (Energy Per Second) multiplier. This creates a progression loop where players can accelerate their energy generation through strategic resets.

## Core Mechanics

### Initial Unlock
- **First Prestige Threshold**: 100 total energy (test value)
- **Status**: System is locked until threshold is reached
- **Multiplier Display**: Shows 0.0x until unlocked

### Multiplier Calculation

The prestige multiplier is calculated as:
```
currentMultiplier = totalEnergy / prestigeThreshold
```

**Example**: 
- Threshold: 100 energy
- Current Energy: 250 energy
- Multiplier: 250 / 100 = 2.5x

### Prestige Unlocking

- **Locked State**: Multiplier < 1.0x (energy below threshold)
- **Unlocked State**: Multiplier ≥ 1.0x (energy meets or exceeds threshold)
- **Visual Feedback**: Button disabled/enabled based on state

## Progression Flow

### Run 1: Initial Game
1. Start with 1.0 EPS from basic energy cell
2. Progress to 100 energy → Prestige unlocks at 1.0x multiplier
3. Continue to 1,000 energy → Prestige shows 10.0x multiplier
4. **Prestige** → Reset to zero, gain 10.0x multiplier

### Run 2: After First Prestige
1. Start with 1.0 × 10.0 = 10.0 EPS
2. Unlock heat cell (50 EPS) → Total: (50 + 1.0) × 10.0 = 510 EPS
3. New threshold: 1,000 energy (previous prestige point)
4. Reach 1,500 energy → Multiplier: 1,500 / 1,000 = 1.5x
5. **Prestige** → Total multiplier: 10.0 + 1.5 = 11.5x

### Run N: Subsequent Runs
- **Total Multiplier**: Sum of all prestige gains
- **Threshold**: Previous run's prestige energy
- **EPS Formula**: `(cellEPS₁ + cellEPS₂ + ... + cellEPSₙ) × totalMultiplier`

## Data Structure

### PrestigeState
```dart
{
  totalMultiplier: BigNumber,      // Sum of all prestige gains
  currentThreshold: BigNumber,     // Energy needed for next prestige
  currentMultiplier: BigNumber,    // Current run's potential gain
  isUnlocked: bool,                // Can prestige now
  prestigeCount: int,              // Number of times prestiged
}
```

## Reset Behavior

When prestiging:
1. **Reset**: Energy → 0, all cells → locked/level 1
2. **Add**: Current multiplier to total multiplier
3. **Update**: Threshold to current energy value
4. **Increment**: Prestige count
5. **Persist**: Save state to storage
6. **Restart**: Begin progression with new multiplier

## Integration Points

### Services Layer
- `PrestigeService`: Manages prestige state and calculations
- Listens to `EnergyService.energy$` for threshold checks
- Emits `prestigeState$` stream for UI updates

### Cubits Layer
- `PrestigeCubit`: Wraps PrestigeService for BLoC pattern
- Handles prestige action trigger
- Coordinates reset with other services

### UI Layer
- `PrestigeInfoSection`: Displays multiplier, progress, button
- Real-time updates via stream subscriptions
- Visual states: locked/unlocked/ready

## Persistence

Prestige data is saved to local storage:
```dart
{
  'totalMultiplier': String,       // Serialized BigNumber
  'currentThreshold': String,      // Serialized BigNumber
  'prestigeCount': int,
}
```

Loaded on app startup, defaulting to initial values if not found.

## Future Enhancements

- **Prestige Bonuses**: Additional perks beyond multiplier
- **Prestige Milestones**: Special rewards at certain counts
- **Dynamic Thresholds**: Alternative calculation methods
- **Prestige Shop**: Spend prestige currency on upgrades
- **Statistics**: Track fastest prestige, highest multiplier, etc.
