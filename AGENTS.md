# AGENTS.md

- このリポジトリは、私のための AI agent 向け拡張を GitHub 経由で共有・再現するための marketplace / plugin 置き場
- hooks, skills、MCP、scripts、workflow 補助など、一般的な AI agent plugin に入るものを扱う
- 個人のローカル環境そのものではなく、複数マシンで再利用できる agent 拡張 package を管理
- 公開 repo として扱うため、ローカル絶対パス、private hostname、メールアドレス、token、secret、マシン固有値を入れない
- 共通スキルの正本は `skills/` 配下に置く。Codex は plugin 配下の symlink されたスキルを認識しないため、各 plugin には実ファイルを置き、symlink に戻さない
- Codex marketplace は `.agents/plugins/marketplace.json`、plugin 本体は `plugins/` 配下に置く
- `plugins/my-codex/skills/` の各スキルには `agents/openai.yaml` を置き、`interface.display_name`、`interface.short_description`、`interface.default_prompt` を定義する。Codex 専用メタデータのため、共通スキル正本の `skills/` には置かない
- capabilities を増やしたら、`README.md` と `.codex-plugin/plugin.json` の説明を更新する
- コミットメッセージは `type: 日本語の概要` の形式にし、type は Conventional Commits に従う
- 依存する外部スキルは `scripts/install-external-skills.sh` に記述する

## コミット前の手順

作業途中では、共通スキルの同期と version 更新を行わない。
人間のレビュー後、コミット直前に以下を順番に行う。

1. `skills/` を変更した場合だけ、`./scripts/sync-skills.sh` を1回実行する。
2. 同期結果を含め、内容が変わった plugin の manifest version をそれぞれ1回更新する。
   対象は Codex の `plugins/my-codex/.codex-plugin/plugin.json`、AGY の `plugins/my-agy/plugin.json`、OMP の `plugins/my-omp/.omp-plugin/plugin.json`。
   OMP を更新した場合は、`.omp-plugin/marketplace.json` の該当 plugin entry も同じ version にする。
3. 最終差分と関連するチェックを確認してからコミットする。

## version の選び方

現在はベータ版のため、`0.x.y` を維持する。

- 既存内容の修正は patch を上げる（例：`0.14.0` → `0.14.1`）。
- skill や capability の追加、削除、互換性を壊す変更は minor を上げ、patch を `0` に戻す（例：`0.14.1` → `0.15.0`）。
- `1.0.0` への移行は、ユーザーが正式版への移行を明示した場合だけ行う。
