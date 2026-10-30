# anti-recipes documentation

Start here. Each document answers one question, so read only what you need.

| Document | Question it answers |
|----------|---------------------|
| [product-vision.md](product-vision.md) | What are we building, for whom, and what nutrition rules does it enforce? |
| [architecture.md](architecture.md) | How is the code organized, what is stored, and how do the calculations work? |
| [current-status.md](current-status.md) | What exists today, how was it verified, and what is known to be missing? |
| [development-plan.md](development-plan.md) | In what order was it built, and what should be built next? |
| [development-guide.md](development-guide.md) | How do I set up the machine, run, test, branch and extend the project? |
| [backup-format.md](backup-format.md) | What does the JSON backup file look like and how is it versioned? |

Related files outside this folder:

- [`../README.md`](../README.md): short public overview of the project.
- [`../AGENTS.md`](../AGENTS.md): context and working rules for AI coding agents.
- [`../odd/tasks/anti-recipes-mvp.md`](../odd/tasks/anti-recipes-mvp.md): the task logbook of the MVP build (tasks T0 to T9, evidence, review outcomes).

## Conventions used in these documents

- Statements marked **Verified** were checked against the code, a test run or the running app.
- Statements marked **Proposal** or **Assumption** are not decisions. They need a product decision before work starts.
- Dates are absolute. Documents describe the repository as of the date in [current-status.md](current-status.md).
