# AGENTS.md

- このリポジトリは、私のための AI agent 向け拡張を GitHub 経由で共有・再現するための marketplace / plugin 置き場
- hooks, skills、MCP、scripts、workflow 補助など、一般的な AI agent plugin に入るものを扱う
- 個人のローカル環境そのものではなく、複数マシンで再利用できる agent 拡張 package を管理
- 公開 repo として扱うため、ローカル絶対パス、private hostname、メールアドレス、token、secret、マシン固有値を入れない
- 共通スキルの正本は `skills/` 配下に置く。Codex は plugin 配下の symlink されたスキルを認識しないため、各 plugin には実ファイルを置き、symlink に戻さない
- Codex marketplace は `.agents/plugins/marketplace.json`、plugin 本体は `plugins/` 配下に置く
- `plugins/my-codex/skills/` の各スキルには `agents/openai.yaml` を置き、`interface.display_name`、`interface.short_description`、`interface.default_prompt` を定義する。Codex 専用メタデータのため、共通スキル正本の `skills/` には置かない
- 人間のレビュー後、コミット直前に最終処理を行う。共通スキルを変更した場合は `./scripts/sync-skills.sh` を1回だけ実行して各 plugin に同期し、その後、変更した plugin の manifest version を1回だけ更新する。OMP plugin は `plugins/my-omp/.omp-plugin/plugin.json` と `.omp-plugin/marketplace.json` の該当 plugin entry の version を一致させる。作業途中では同期や version 更新を行わない。新しい skill や capability の追加は minor、既存内容の修正は patch、互換性を壊す変更は major とする
- capabilities を増やしたら、`README.md` と `.codex-plugin/plugin.json` の説明を更新する
- コミットメッセージは `type: 日本語の概要` の形式にし、type は Conventional Commits に従う
- 依存する外部スキルは `scripts/install-external-skills.sh` に記述する
