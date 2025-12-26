#!/bin/bash
set -e

# Build Elm
echo "Building Elm..."
elm make src/Main.elm --output=elm.js --optimize

# Generate cache-busting timestamp
CACHE_BUST=$(date +%s)

# Generate index.html with cache-busted script
echo "Generating index.html with cache bust: $CACHE_BUST"
cat > index.html << EOF
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Interface Design Experiment</title>
</head>
<body>
    <div id="app"></div>
    <script src="elm.js?v=$CACHE_BUST"></script>
    <script>
        var app = Elm.Main.init({
            node: document.getElementById('app')
        });
    </script>
</body>
</html>
EOF

# Deploy to server
echo "Deploying to experiments server..."
scp elm.js index.html root@67.207.84.183:/var/www/experiments/

echo "Done! View at http://67.207.84.183/"
