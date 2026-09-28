# Site checks

Every 10 minutes GitHub Actions opens each address in `sites.txt` and checks that it answers and shows the
expected text. If one is down the run fails and GitHub sends an email to the account owner.

- Add or remove a site: edit `sites.txt`.
- Run a check now: Actions → Check sites → Run workflow.
