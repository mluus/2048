$ ->

    # creating rows and columns
  ppArray = (array) ->
    for row in array
      console.log row

  @board = [0..3].map (x) -> [0..3].map (y) -> 0

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
        # get random value for tile
      val = randomValue()
        # get random position
      [x, y] = getRandomCellIndecies()
        # only if the cell = 0
      if board[x][y] == 0
        board[x][y] = val
      else
        generateTile(board)



  getRow = (rowNumber, board) ->
    board[rowNumber]

  getColumn = (columnNumber, board) ->
    column = []
    for row in [0..3]
      column.push board[row][columnNumber]
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



  showBoard = (board) ->
    for x in [0..3]
      for y in [0..3]

        if (board[x][y]) !=0
          $(".r#{x}.c#{y} > div").html(board[x][y])
        else
          $(".r#{x}.c#{y} > div").html('')



  move = (board, direction) ->

    switch direction
      when 'right'
        for i in [3..0]
          row = getRow(i, board)
          row = mergeCells(row, 'right')
          row = collapseCells(row, 'right')
          setRow(row, i, board)

        ppArray board

      when 'left'
        for i in [0..3]
          row = getRow(i, board)
          row = mergeCells(row, 'left')
          row = collapseCells(row, 'left')
          setRow(row, i, board)

        ppArray board

      when 'up'
        for i in [0..3]
          newArray = getColumn(i, board)
          newArray = mergeCells(newArray, 'up')
          newArray = collapseCells(newArray, 'up')
          setColumn(newArray, i, board)

        ppArray board

      when 'down'
        for i in [3..0]
          newArray = getColumn(i, board)
          newArray = mergeCells(newArray, 'down')
          newArray = collapseCells(newArray, 'down')
          setColumn(newArray, i, board)

    generateTile(board)
    showBoard(board)

  $('body').keydown (e) =>
    key = e.which
    keys = [37..40]

    if $.inArray(key, keys) > -1
      e.preventDefault()

    switch key
      when 37
        console.log 'left'
        move(@board, 'left')
        generateTile(@board)
      when 38
        console.log 'up'
        move(@board, 'up')
        generateTile(@board)
      when 39
        console.log 'right'
        move(@board, 'right')
        generateTile(@board)
      when 40
        console.log 'down'
        move(@board, 'down')
        generateTile(@board)

  noValidMove = (board) ->
    for x in [0..3]
      for y in [0..3]
        if board[x][y]
          console.log board


  generateTile(@board)
  generateTile(@board)
  showBoard(@board)
  ppArray(@board)









































