# Directories and files paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_DIR="${SCRIPT_DIR}/logs"
LOG_FILE="${LOG_DIR}/log.${SCRIPT_NAME}.${SCRIPT_VERSION}.log"
RESULTS_DIR="${SCRIPT_DIR}/results"
TEMPLATES_DIR="${SCRIPT_DIR"
cd $TEMPLATES_DIR

cat > shell.gitignore <<'EOF'
# Template : shell
# Description : shell scriting compatihle with v110 and minimum
# Maintainer : Bruno DELNOZ
# Last update : 2025-10-25
# Compatible with : shell command
logs/
output/
infos/
result/
results/
*.log
*.zip
*.tar.gz
*.rar
EOF
cat > java.gitignore <<'EOF'
# Template : Java
# Description : Java compiled files, build tools (Maven, Gradle)
# Maintainer : Bruno DELNOZ
# Last update : 2025-10-25
# Compatible with : Java, Maven, Gradle, IntelliJ IDEA, Eclipse
*.class
*.log
*.ctxt
.mtj.tmp/
*.jar
*.war
*.nar
*.ear
*.zip
*.tar.gz
*.rar
hs_err_pid*
replay_pid*
target/
pom.xml.tag
pom.xml.releaseBackup
pom.xml.versionsBackup
pom.xml.next
release.properties
dependency-reduced-pom.xml
buildNumber.properties
.mvn/timing.properties
.mvn/wrapper/maven-wrapper.jar
.gradle/
build/
!.gradle/wrapper/gradle-wrapper.jar
.idea/
*.iws
*.iml
*.ipr
out/
.classpath
.project
.settings/
bin/
.vscode/
.DS_Store
EOF


cat > cpp.gitignore <<'EOF'
# Template : C++
*.d
*.o
*.obj
*.so
*.a
*.lib
*.exe
*.out
build/
CMakeCache.txt
CMakeFiles/
cmake_install.cmake
Makefile
.vs/
*.sln.docstates
EOF

cat > rust.gitignore <<'EOF'
# Template : Rust
target/
Cargo.lock
**/*.rs.bk
*.pdb
flamegraph.svg
perf.data*
EOF

cat > go.gitignore <<'EOF'
# Template : Go
*.exe
*.dll
*.so
*.dylib
*.test
*.out
vendor/
go.work
bin/
pkg/
EOF

cat > ruby.gitignore <<'EOF'
# Template : Ruby
*.gem
*.rbc
.bundle/
vendor/bundle
coverage/
tmp/
log/*
.env
.byebug_history
EOF

cat > php.gitignore <<'EOF'
# Template : PHP
/vendor/
composer.lock
.env
/node_modules/
.phpunit.result.cache
.idea/
EOF

cat > dotnet.gitignore <<'EOF'
# Template : .NET
bin/
obj/
.vs/
*.user
*.suo
*.pdb
EOF

cat > swift.gitignore <<'EOF'
# Template : Swift
build/
DerivedData/
Pods/
Carthage/Build/
.build/
.swiftpm/
EOF

cat > android.gitignore <<'EOF'
# Template : Android
.gradle/
build/
.idea/
*.iml
*.apk
*.aab
local.properties
EOF

cat > django.gitignore <<'EOF'
# Template : Django
__pycache__/
*.py[cod]
db.sqlite3
media/
staticfiles/
.env
EOF

cat > laravel.gitignore <<'EOF'
# Template : Laravel
/vendor/
/node_modules/
.env
storage/*.key
public/storage
EOF

cat > rails.gitignore <<'EOF'
# Template : Rails
/vendor/bundle
/log/*
/tmp/*
/storage/*
.env
EOF

cat > unity.gitignore <<'EOF'
# Template : Unity
Library/
Temp/
Obj/
Build/
Logs/
UserSettings/
EOF

cat > macos.gitignore <<'EOF'
# Template : macOS
.DS_Store
.AppleDouble
.LSOverride
EOF

cat > linux.gitignore <<'EOF'
# Template : Linux
*~
.Trash-*
.nfs*
EOF

cat > windows.gitignore <<'EOF'
# Template : Windows
Thumbs.db
Desktop.ini
$RECYCLE.BIN/
EOF

cat > vscode.gitignore <<'EOF'
# Template : VSCode
.vscode/
!.vscode/settings.json
!.vscode/extensions.json
EOF

cat > jetbrains.gitignore <<'EOF'
# Template : JetBrains
.idea/
*.iml
cmake-build-*/
EOF

cat > vim.gitignore <<'EOF'
# Template : Vim
*.swp
*.swo
*.un~
Session.vim
EOF

cat > sublime.gitignore <<'EOF'
# Template : Sublime
*.sublime-workspace
sftp-config.json
EOF

cat > docker.gitignore <<'EOF'
# Template : Docker
.env
docker-compose.override.yml
volumes/
secrets/
EOF

cat > terraform.gitignore <<'EOF'
# Template : Terraform
.terraform/
*.tfstate*
*.tfvars
.terraform.lock.hcl
EOF
