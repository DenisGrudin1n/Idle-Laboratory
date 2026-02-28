# idle_laboratory

An idle clicker game built with Flutter featuring reactive stream-based architecture.

## Features

### Stream-Based Architecture
The game utilizes a reactive architecture with RxDart streams for real-time state management. See [STREAM_ARCHITECTURE.md](STREAM_ARCHITECTURE.md) for detailed documentation.

### Prestige System
Progressive reset mechanism that provides permanent multipliers for faster gameplay. See [PRESTIGE_SYSTEM.md](PRESTIGE_SYSTEM.md) for complete mechanics.

### Energy System
- Real-time energy generation
- Multiple energy cells with different production rates
- Automatic progression and cell unlocking

## Architecture

- **Services Layer**: Pure business logic with RxDart streams
- **Cubits Layer**: BLoC pattern wrappers for UI state
- **UI Layer**: Reactive widgets with stream builders

## Getting Started

This project is built with Flutter. To run:

```bash
flutter pub get
flutter run
```

## Documentation

- [Stream Architecture](STREAM_ARCHITECTURE.md) - Reactive architecture details
- [Prestige System](PRESTIGE_SYSTEM.md) - Prestige mechanics and progression
