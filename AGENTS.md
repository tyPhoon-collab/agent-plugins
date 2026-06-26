# AGENTS.md

- このリポジトリは、私のための AI agent 向け拡張を GitHub 経由で共有・再現するための marketplace / plugin 置き場
- hooks, skills、MCP、scripts、workflow 補助など、一般的な AI agent plugin に入るものを扱う
- 個人のローカル環境そのものではなく、複数マシンで再利用できる agent 拡張 package を管理
- 公開 repo として扱うため、ローカル絶対パス、private hostname、メールアドレス、token、secret、マシン固有値を入れない
- Codex marketplace は `.agents/plugins/marketplace.json`、plugin 本体は `plugins/` 配下に置く
- capabilities を増やしたら、`README.md` と `.codex-plugin/plugin.json` の説明を更新する
- コミットメッセージは `type: 日本語の概要` の形式にし、type は Conventional Commits に従う
