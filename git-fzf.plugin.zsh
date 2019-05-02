_fzf_complete_ga() {
    _fzf_complete "--multi" "$@" < <(
        git status -s | awk '/^.\S/'
    )
}

_fzf_complete_ga_post() {
    awk '{print $2}'
}

_fzf_complete_gco() {
    _fzf_complete "--multi" "$@" < <(
        git status -s | awk '/^.[^ ?]/'
        git branch --all --sort=-committerdate | sed 's|^| |'
        git tag | sed 's|^| t |'
    )
}

_fzf_complete_gco_post() {
    cut -c 3- | awk '{print $1}' | sed "s|remotes/[^/]*/||"
}

_fzf_complete_grh() {
    _fzf_complete "--multi" "$@" < <(
        git status -s | awk '/^[^ ?]/'
    )
}

_fzf_complete_grh_post() {
    awk '{print $2}'
}

_fzf_complete_gd() {
    _fzf_complete "--multi" "$@" < <(
        git status -s | awk '/^.[^ ?]/'
    )
}

_fzf_complete_gd_post() {
    awk '{print $2}'
}

_fzf_complete_gdca() {
    _fzf_complete "--multi" "$@" < <(
        git status -s | awk '/^[^ ?]/'
    )
}

_fzf_complete_gdca_post() {
    awk '{print $2}'
}
