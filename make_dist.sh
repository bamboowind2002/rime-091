[[ ! -d dist ]] && mkdir ./dist
uv run work.py
cp -r ./lua ./dist
cp wubi091.schema.yaml ./dist
cp recipe.yaml ./dist