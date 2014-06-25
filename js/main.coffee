

$ ->

  # creating rows and columns
  ppArray = (array) ->
    for row in array
      console.log row

  @board = [0..3].map (x) -> [0..3].map (y) -> 0

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

    $('body').keydown (e) ->
      key = e.which
      keys = [37..40]

      if $.inArray(key, keys) > -1
        e.preventDefault()

      switch key
        when 37
          console.log 'left'
        when 38
          console.log 'up'
        when 39
          console.log 'right'
        when 40
          console.log 'down'

  generateTile(@board)
  generateTile(@board)
  ppArray(@board)

 getRow = (rowNumber, board) ->
    board [rowNumber]

 getColumn = (columnNumber, board) ->
    Column = []
    for row in [0..3]
      column.push board[row][columnNumber]
    column

getColumnv2 = (c, b) ->
    b = board
    [b[0][c], b[1][c], b[2][c], b[3][c]]

 getColumnV3 = (c, b) ->
    col = []
    for r in b
      col.push r[c]
    col

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
        for x in [y + 1..3]
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
        for x in [y + 3..1]
          if cells[x] == cells[y]
            cells[x] = cells[x] * 2
            cells[y] = 0
            break
          else if cells[x] == 0
            break
          else if cells[y] != 0
            break
  cells


console.log "hi" + collapseCells( mergeCells([2, 2, 0, 0], "right"), "right")
console.log "hi" + collapseCells([2, 2, 0, 0], "right")


#             cells[counter] = cells[counter] * 2
#             cells[counter - 1] = 0
#       when "left", "up"
#         padding = cells.length - 1
#         for counter in [0..padding]
#           if cells[counter] == cells[counter + 1]
#             cells[counter] = cells[counter] * 2
#             cells[counter + 1] = 0
#     console.log "final" + collapseCells(cells, direction)
#     cells

  # console.log mergeCells([2, 2, 2 ,0 ], "down")





# mergeCells = (cells, direction) ->
#       padding = cells.length
#       switch direction
#         when "right", "down"
#           padding = cells.length
#           for counter in [0..padding]
#             if cells[counter + 1] == 0
#               cells[counter + 1] = cells[counter]
#               cells[counter] = 0
#           console.log cells
#           for counter in [padding..1]
#           # if cells[counter - 1] != 0
#               if cells[counter] == cells[counter - 1]
#                 cells[counter] = cells[counter] * 2
#                 cells[counter - 1] = 0
#         when "left", "up"
#           padding = cells.length
#           for counter in [padding..1]
#             if cells[counter - 1] == 0
#               cells[counter - 1] = cells[counter]
#               cells[counter] = 0
#           console.log cells
#           padding = cells.length - 1
#           for counter in [0..padding]
#               if cells[counter] == cells[counter + 1]
#                 cells[counter] = cells[counter] * 2
#                 cells[counter + 1] = 0
#       console.log "final results " +  cells
#       cells































