_zpcompinit_custom() {
  setopt extendedglob local_options
  autoload -Uz compinit
  
  local zcd=$ZSH_CACHE_DIR/zcompdump-$ZSH_VERSION
  local zcdc="$zcd.zwc"

  # Compile the completion dump to increase startup speed, if dump is newer or doesn't exist,
  # in the background as this is doesn't affect the current session
  if [[ -f "$zcd"(#qN.m+1) ]]; then
        compinit -i -d "$zcd"
        { rm -f "$zcdc" && zcompile "$zcd" } &!
  else
        compinit -C -d "$zcd"
        { [[ ! -f "$zcdc" || "$zcd" -nt "$zcdc" ]] && rm -f "$zcdc" && zcompile "$zcd" } &!
  fi
}