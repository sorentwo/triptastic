# Triptastic

An Ecto 2.0 sample application that compares naive filtering and window queries.

## Installation

Clone the repository and then follow these `mix` steps:

```bash
mix deps.get, ecto.create, ecto.migrate
```

Now you're ready to run the tests:

```bash
mix test
```

## Results

Initial results in table form:

```
| trips | memory  | window | joined |
| ----- | ------- | ------ | ------ |
| 100   | 2.464   | 2.129  | 1.9    |
| 500   | 22.088  | 3.479  | 3.31   |
| 5000  | 34.62   | 19.747 | 19.18  |
| 10000 | 69.435  | 38.229 | 49.30  |
| 20000 | 147.987 | 76.326 | 80.93  |
```

## License

MIT License, Copyright (c) 2016 Parker Selbert
