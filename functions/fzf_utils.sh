######################
# for kube
######################
kevict() {
    kubectl get pods | awk '{if ($3 ~ /Evicted/) system ("kubectl delete pods " $1)}'
}
desc() {
    local selected tokens
    selected=$(
        kubectl get pods --all-namespaces |
            fzf --info=inline --layout=reverse --header-lines=1 --border \
                --prompt "$(kubectl config current-context | sed 's/-context$//')> " \
                --header $'Press CTRL-O to open log in editor\n\n' \
                --bind ctrl-/:toggle-preview \
                --bind 'ctrl-o:execute:${EDITOR:-vim} <(kubectl logs --namespace {1} {2}) > /dev/tty' \
                --preview-window up \
                --preview 'kubectl logs --follow --tail=100000 --namespace {1} {2}' "$@"
    )
    read -ra tokens <<<"$selected"
    [ ${#tokens} -gt 1 ] &&
        kubectl describe pod --namespace "${tokens[0]}" "${tokens[1]}" | less
}
logs() {
    local selected tokens
    selected=$(
        kubectl get pods --all-namespaces |
            fzf --info=inline --layout=reverse --header-lines=0 --border \
                --prompt "$(kubectl config current-context | sed 's/-context$//')> " \
                --header $'Press CTRL-O to open log in editor\n\n' \
                --bind ctrl-/:toggle-preview \
                --bind 'ctrl-o:execute:${EDITOR:-vim} <(kubectl logs --namespace {1} {2}) > /dev/tty' \
                --preview-window up \
                --preview 'kubectl logs --follow --tail=100000 --namespace {1} {2}' "$@"
    )
    read -ra tokens <<<"$selected"
    [ ${#tokens} -gt 1 ] &&
        kubectl logs --namespace "${tokens[0]}" "${tokens[1]}" | less
}
logf() {
    local selected tokens
    selected=$(
        kubectl get pods --all-namespaces |
            fzf --info=inline --layout=reverse --header-lines=0 --border \
                --prompt "$(kubectl config current-context | sed 's/-context$//')> " \
                --header $'Press CTRL-O to open log in editor\n\n' \
                --bind ctrl-/:toggle-preview \
                --bind 'ctrl-o:execute:${EDITOR:-vim} <(kubectl logs --namespace {1} {2}) > /dev/tty' \
                --preview-window up \
                --preview 'kubectl logs --follow --tail=100000 --namespace {1} {2}' "$@"
    )
    read -ra tokens <<<"$selected"
    [ ${#tokens} -gt 1 ] &&
        kubectl logs -f --namespace "${tokens[0]}" "${tokens[1]}"
}
pods() {
    local selected tokens
    selected=$(
        kubectl get pods --all-namespaces |
            fzf --info=inline --layout=reverse --header-lines=0 --border \
                --prompt "$(kubectl config current-context | sed 's/-context$//')> " \
                --header $'Press CTRL-O to open log in editor\n\n' \
                --bind ctrl-/:toggle-preview \
                --bind 'ctrl-o:execute:${EDITOR:-vim} <(kubectl logs --namespace {1} {2}) > /dev/tty' \
                --preview-window up \
                --preview 'kubectl logs --follow --tail=100000 --namespace {1} {2}' "$@"
    )
    read -ra tokens <<<"$selected"
    [ ${#tokens} -gt 1 ] &&
        echo kubectl exec -it --namespace "${tokens[0]}" "${tokens[1]}" -- bash &&
        kubectl exec -it --namespace "${tokens[0]}" "${tokens[1]}" -- bash
}
if [[ $(which kubectl) ]]; then
    source <(kubectl completion bash) 2>/dev/null
fi


######################
# for docker
######################
# search registry
regd() {
    local HOST=192.168.1.1
    local PORT=5000
    local selected tokens
    selected=$(
        curl --noproxy $HOST http://$HOST:$PORT/v2/_catalog 2>/dev/null | jq . |
            fzf --info=inline --layout=reverse --header-lines=0 --border \
                --header $'Press CTRL-O to open log in editor\n\n'
    )
    read -ra tokens <<<"$selected"
    [ ${#tokens} -gt 1 ] &&
        VAL=$(echo ${tokens[0]} | sed "s/,//g" | sed 's/"//g') &&
        curl --noproxy $HOST http://$HOST:$PORT/v2/${VAL}/tags/list 2>/dev/null | jq . | less
}
# docker exec bash
dk() {
    local selected tokens
    selected=$(
        docker ps |
            fzf --info=inline --layout=reverse --header-lines=0 --border
    )
    read -ra tokens <<<"$selected"
    [ ${#tokens} -gt 1 ] &&
        docker exec -it "${tokens[0]}" bash
}
# docker exec sh
dks() {
    local selected tokens
    selected=$(
        docker ps |
            fzf --info=inline --layout=reverse --header-lines=0 --border
    )
    read -ra tokens <<<"$selected"
    [ ${#tokens} -gt 1 ] &&
        docker exec -it "${tokens[0]}" sh
}
# docker rmi
dki() {
    local selected tokens
    selected=$(
        docker images |
            fzf --info=inline --layout=reverse --header-lines=0 --border
    )
    read -ra tokens <<<"$selected"
    [ ${#tokens} -gt 1 ] &&
        docker rmi "${tokens[2]}"
}
# docker rm
dkrm() {
    local selected tokens
    selected=$(
        docker ps -a |
            fzf --info=inline --layout=reverse --header-lines=0 --border
    )
    read -ra tokens <<<"$selected"
    [ ${#tokens} -gt 1 ] &&
        docker rm "${tokens[0]}"
}
# docker stop(kill)
dkk() {
    local selected tokens
    selected=$(
        docker ps |
            fzf --info=inline --layout=reverse --header-lines=0 --border
    )
    read -ra tokens <<<"$selected"
    [ ${#tokens} -gt 1 ] &&
        docker stop "${tokens[0]}"
}
######################
# for git
######################
# git add
gaa() {
    local selected tokens
    selected=$(
        git diff --name-only master origin/master |
            fzf --info=inline --layout=reverse --header-lines=0 --border \
                --prompt "git add > " \
                --header $'Press CTRL-O to open log in editor\n\n' \
                --bind ctrl-/:toggle-preview \
                --bind 'ctrl-o:execute:${EDITOR:-vim} <(git diff {1}) > /dev/tty' \
                --preview-window up \
                --preview 'git diff {1}' "$@"
    )
    read -ra tokens <<<"$selected"
    [ ${#tokens} -gt 1 ] &&
        git add "${tokens[0]}"
}
# git diff
gdd() {
    local selected tokens
    selected=$(
        git diff --name-only master origin/master |
            fzf --info=inline --layout=reverse --header-lines=0 --border \
                --prompt "git diff > " \
                --header $'Press CTRL-O to open log in editor\n\n' \
                --bind ctrl-/:toggle-preview \
                --bind 'ctrl-o:execute:${EDITOR:-vim} <(git diff master origin/master {1}) > /dev/tty' \
                --preview-window up \
                --preview 'git diff master origin/master {1}' "$@"
    )
    read -ra tokens <<<"$selected"
    [ ${#tokens} -gt 1 ] &&
        git difftool -y master origin/master "${tokens[0]}"
}
# git difftool
gddd() {
    local selected tokens
    selected=$(
        git diff --cached --name-only |
            fzf --info=inline --layout=reverse --header-lines=0 --border \
                --prompt "git diff > " \
                --header $'Press CTRL-O to open log in editor\n\n' \
                --bind ctrl-/:toggle-preview \
                --bind 'ctrl-o:execute:${EDITOR:-vim} <(git diff --cached {1}) > /dev/tty' \
                --preview-window up \
                --preview 'git diff --cached {1}' "$@"
    )
    read -ra tokens <<<"$selected"
    [ ${#tokens} -gt 1 ] &&
        git difftool -y --cached "${tokens[0]}"
    #git mergetool --tool=vimdiff  "${tokens[0]}"
}
######################
# for repo
######################
repoa() {
    local selected tokens
    selected=$(
        repo forall -c pwd |
            fzf --info=inline --layout=reverse --header-lines=0 --border \
                --prompt "> " \
                --preview-window up \
                --preview 'ls -al {1}' "$@"
    )
    read -ra tokens <<<"$selected"
    [ ${#tokens} -gt 1 ] &&
        cd "${tokens[0]}"
}

