function! TodoList()
        let g:todo_ignore_dir=['.\*env\*/', '.git']

        " Prepare command
        let l:ignore_list=join(g:todo_ignore_dir, ',')
        let l:cmd = ":grep! -e 'TODO: .*' .  -T -o --recursive --exclude-dir={" . l:ignore_list . "}"

        " Redirect output of l:cmd to the string rawtoto
        let l:rawtodo=""
        :silent :redir =>> l:rawtodo
        :silent :execute l:cmd
        :silent :redir END

        let l:todolst=split(l:rawtodo, '\n')[2:]
        echo "Todo List:"
        echo " - " . join(l:todolst, "\n - ") . "\n"

        " 1. DONE: List all todo comments using grep
        " 2. TODO: Display them in a new window
        " 3. TODO: Have some Go To functionality for each found todo
        echo "Not complete atm... 😞"
endfunction

nnoremap <leader>to :call TodoList()<CR>
