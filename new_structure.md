lib/
  core/                     # Shared stuff used across all features
    network/
      dio_client.dart
    errors/
      app_exception.dart
    utils/
      validators.dart
    providers.dart           # Shared global providers (Dio, etc.)

  features/
    auth/
      data/
        datasources/
        models/
        repositories/
      domain/
        entities/
        repositories/
        usecases/
      application/
        providers/
      presentation/
        pages/
        widgets/

    products/
      ... same 4 layers ...

    cart/
      ... same 4 layers ...

  main.dart
  app.dart                   # Top-level MaterialApp + routing
