$ ->

  WinningTileValue = 2048

  # creating rows and columns
  ppArray = (array) ->
    for row in array
      console.log row


  buildBoard = ->
    [0..3].map (x) -> [0..3].map (y) -> 0


  getRow = (rowNumber, board) ->
    [r, b] = [rowNumber, board]
    [b[r][0], b[r][1], b[r][2], b[r][3]]



  arrayEqual = (a, b)->
    for val, i in a
      if val != b[i]
        return false
    true

  boardEqual = (a, b) ->
    for row, i in a
      unless arrayEqual(row, b[i])
        return false
    true



  MoveIsValid = (a, b) ->
    not boardEqual(a,b)

  noValidMoves = (board) ->
    directions = ['up', 'down', 'left', 'right']
    for direction in directions
      newBoard = move(board, direction)
      return false if moveIsValid(newBoard, board)
    true


  randomIndex = (x) ->
    Math.floor(Math.random() * 4)

  getRandomCellIndecies = ->
    [randomIndex(4), randomIndex(4)]

  randomValue = ->
    values = [2,2,2,2,2,4]
    val = values[randomIndex(values.length)]

  boardIsFull = (board) ->
    for x in [0..3]
      for y in [0..3]
        if board[x][y] == 0
          return false
    true

  generateTile = (board) ->
    unless boardIsFull(board)
      val = randomValue()
      [x, y] = getRandomCellIndecies()
      if board[x][y] == 0
        board[x][y] = val
      else
        generateTile(board)


  getColumn = (columnNumber, board) ->
    column = []
    for row in [0..3]
      column[row] = board[row][columnNumber]
    column

  setRow = (row, rowNumber, board) ->
    board[rowNumber] = row


  getColumnv2 = (c, b) ->
    b = board
    [b[0][c], b[1][c], b[2][c], b[3][c]]

  getColumnV3 = (c, b) ->
    col = []
    for r in b
      col.push r[c]
    col


  setColumn = (newArray, columnNumber, board) ->
    b = board
    c = columnNumber
    [b[0][c], b[1][c], b[2][c], b[3][c]] = newArray

      # setColumn([2, 2, 2, 2 ], 3, @board)
      # ppArray setColumn


  collapseCells = (cells, direction) ->
    cells = cells.filter (x) -> x != 0
    padding = 4 - cells.length
    for i in [1..padding]
      switch direction
        when 'right', 'down' then cells.unshift 0
        when 'left', 'up' then cells.push 0
    cells


  mergeCells = (cells, direction) ->
    switch direction
      when "right", "down"
        for y in [0...3]
          for x in [y+1..3]
            if cells[x] == cells[y]
              cells[x] = cells[x] * 2
              cells[y] = 0
              break
            else if cells[x] == 0
              break
            else if cells[y] != 0
              break
      when "left", "up"
        for y in [3...0]
          for x in [y-1..0]
            if cells[x] == cells[y]
              cells[x] = cells[x] * 2
              cells[y] = 0
              break
            else if cells[x] == 0
              break
            else if cells[y] != 0
              break
    cells


  gameWon = (board) ->
    for row in board
      for cell in row
        if cell >= WinningTileValue
          return true
    false

  gameLost = (board) ->
    boardIsFull(board) && noValidMoves(board)



  showBoard = (board) ->
    for x in [0..3]
      for y in [0..3]
        $(".r#{x}.c#{y}").css("background-color", colorChange(board[x][y]))
        if (board[x][y]) !=0
          $(".r#{x}.c#{y}").html(board[x][y])
        else
          $(".r#{x}.c#{y}").html('')


  colorChange = (board) ->
    switch board
      when 0 then "#e69a3d"
      when 2 then "#d7342d"
      when 4 then "#1b7885"
      when 8 then "#949598"
      when 16 then "#f88146"
      when 32 then "#32e5ff"
      when 64 then "#424344"
      when 128 then "#851e1b"
      when 256 then "#852a6f"



  move = (board, direction) ->
    newBoard = buildBoard()
    for i in [0..3]
      switch direction
        when 'right', 'left'
          row = mergeCells(getRow(i, board), direction)
          row = collapseCells(row, direction)
          setRow(row, i, newBoard)
        when 'up', 'down'
          column = mergeCells(getColumn(i, board), direction)
          column = collapseCells(column, direction)
          setColumn(column, i, newBoard)
    newBoard


  $('body').keydown (e) =>
    key = e.which
    keys = [37..40]

    if $.inArray(key, keys) > -1
      e.preventDefault()


    direction = switch key
      when 37 then 'left'
      when 38 then 'up'
      when 39 then 'right'
      when 40 then 'down'

    newBoard = move(@board, direction)

    if MoveIsValid(newBoard, @board)
      @board = newBoard
      generateTile(@board)
      showBoard(@board)
      if gameLost(@board)
        console.log "Game Over"
      else if gameWon(@board)
        console.log "Congrats!"


  @board = buildBoard()
  generateTile(@board)
  generateTile(@board)
  showBoard(@board)










































