# Committer stats
## How to
Run the script in a repository to get your stats.
```bash
committer_stats.bash
```

Or specify another author to get their stats.
```bash
commiter_stats.bash "Nanaa Mihgo"
```

Or specify another author and an after date to get their recent stats.
```bash
commiter_stats.bash "Nanaa Mihgo" 2020-01-01
```

It outputs something like
```
Stats for Nanaa Mihgo on master:
   Commits: 7 (35.0000% of all commits)
   Lines: +781 -6
   Total delta: 775
   Average delta/commit: 193
   Typical commit times:
      11:00-12:00 (4 commits)
      09:00-10:00 (2 commits)
      16:00-17:00 (1 commits)

Stats for all users on master:
   Commits: 20
```