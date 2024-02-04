# Groove Coaster Score Export

Exports your Groove Coaster scores from official website.

**Official website (Groove Coaster My Page) will be shutdown on 2024 April 7th 24:00 JST (GMT+9) or 2024 April 7th 15:00 UTC.**

## Usage

### Environment Variable

*Please consult your main console such as Command Line for Windows or Bash on Nix-based environments to set it up during single session.*

| Name | Description |
| :-: | :-- |
| `SESSION_ID` | Account session to use |

### Executable

```
import.rb [session_id]
```

- `[session_id]` is an optional argument as an alternative way to provide Session ID through argument instead environment

### Output

Program output to file located inside `data` folder, creates if necessary.

## License

MIT.
