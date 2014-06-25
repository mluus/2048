// Generated by CoffeeScript 1.7.1
(function() {
  $(function() {
    var boardIsFull, collapseCells, generateTile, getColumn, getColumnV3, getColumnv2, getRandomCellIndecies, getRow, mergeCells, move, ppArray, randomIndex, randomValue, setColumn, setRow;
    ppArray = function(array) {
      var row, _i, _len, _results;
      _results = [];
      for (_i = 0, _len = array.length; _i < _len; _i++) {
        row = array[_i];
        _results.push(console.log(row));
      }
      return _results;
    };
    this.board = [0, 1, 2, 3].map(function(x) {
      return [0, 1, 2, 3].map(function(y) {
        return 0;
      });
    });
    randomIndex = function(x) {
      return Math.floor(Math.random() * 4);
    };
    getRandomCellIndecies = function() {
      return [randomIndex(4), randomIndex(4)];
    };
    randomValue = function() {
      var val, values;
      values = [2, 2, 2, 2, 2, 4];
      return val = values[randomIndex(values.length)];
    };
    boardIsFull = function(board) {
      var x, y, _i, _j;
      for (x = _i = 0; _i <= 3; x = ++_i) {
        for (y = _j = 0; _j <= 3; y = ++_j) {
          if (board[x][y] === 0) {
            return false;
          }
        }
      }
      return true;
    };
    generateTile = function(board) {
      var val, x, y, _ref;
      if (!boardIsFull(board)) {
        val = randomValue();
        _ref = getRandomCellIndecies(), x = _ref[0], y = _ref[1];
        if (board[x][y] === 0) {
          return board[x][y] = val;
        } else {
          return generateTile(board);
        }
      }
    };
    $('body').keydown((function(_this) {
      return function(e) {
        var key, keys;
        key = e.which;
        keys = [37, 38, 39, 40];
        if ($.inArray(key, keys) > -1) {
          e.preventDefault();
          switch (key) {
            case 37:
              console.log('left');
              return move(_this.board, 'left');
            case 38:
              console.log('up');
              return move(_this.board, 'up');
            case 39:
              console.log('right');
              return move(_this.board, 'right');
            case 40:
              console.log('down');
              return move(_this.board, 'down');
          }
        }
      };
    })(this));
    generateTile(this.board);
    generateTile(this.board);
    ppArray(this.board);
    getRow = function(rowNumber, board) {
      return board[rowNumber];
    };
    getColumn = function(columnNumber, board) {
      var column, row, _i;
      column = [];
      for (row = _i = 0; _i <= 3; row = ++_i) {
        column.push(board[row][columnNumber]);
      }
      return column;
    };
    setRow = function(row, rowNumber, board) {
      return board[rowNumber] = row;
    };
    getColumnv2 = function(c, b) {
      b = board;
      return [b[0][c], b[1][c], b[2][c], b[3][c]];
    };
    getColumnV3 = function(c, b) {
      var col, r, _i, _len;
      col = [];
      for (_i = 0, _len = b.length; _i < _len; _i++) {
        r = b[_i];
        col.push(r[c]);
      }
      return col;
    };
    setColumn = function(newArray, columnNumber, board) {
      var b, c;
      b = board;
      c = columnNumber;
      return b[0][c] = newArray[0], b[1][c] = newArray[1], b[2][c] = newArray[2], b[3][c] = newArray[3], newArray;
    };
    collapseCells = function(cells, direction) {
      var i, padding, _i;
      cells = cells.filter(function(x) {
        return x !== 0;
      });
      padding = 4 - cells.length;
      for (i = _i = 1; 1 <= padding ? _i <= padding : _i >= padding; i = 1 <= padding ? ++_i : --_i) {
        switch (direction) {
          case 'right':
          case 'down':
            cells.unshift(0);
            break;
          case 'left':
          case 'up':
            cells.push(0);
        }
      }
      return cells;
    };
    mergeCells = function(cells, direction) {
      var x, y, _i, _j, _k, _l, _ref, _ref1;
      switch (direction) {
        case "right":
        case "down":
          for (y = _i = 0; _i < 3; y = ++_i) {
            for (x = _j = _ref = y + 1; _ref <= 3 ? _j <= 3 : _j >= 3; x = _ref <= 3 ? ++_j : --_j) {
              if (cells[x] === cells[y]) {
                cells[x] = cells[x] * 2;
                cells[y] = 0;
                break;
              } else if (cells[x] === 0) {
                break;
              } else if (cells[y] !== 0) {
                break;
              }
            }
          }
          break;
        case "left":
        case "up":
          for (y = _k = 3; _k > 0; y = --_k) {
            for (x = _l = _ref1 = y + 3; _ref1 <= 1 ? _l <= 1 : _l >= 1; x = _ref1 <= 1 ? ++_l : --_l) {
              if (cells[x] === cells[y]) {
                cells[x] = cells[x] * 2;
                cells[y] = 0;
                break;
              } else if (cells[x] === 0) {
                break;
              } else if (cells[y] !== 0) {
                break;
              }
            }
          }
      }
      return cells;
    };
    move = function(board, direction) {
      var i, newArray, row, _i, _j, _k, _l, _results, _results1, _results2, _results3;
      switch (direction) {
        case 'right':
          _results = [];
          for (i = _i = 3; _i >= 0; i = --_i) {
            row = getRow(i, board);
            row = mergeCells(row, 'right');
            row = collapseCells(row, 'right');
            setRow(row, i, board);
            _results.push(ppArray(board));
          }
          return _results;
          break;
        case 'left':
          _results1 = [];
          for (i = _j = 0; _j <= 3; i = ++_j) {
            row = getRow(i, board);
            row = mergeCells(row, 'left');
            row = collapseCells(row, 'left');
            setRow(row, i, board);
            _results1.push(ppArray(board));
          }
          return _results1;
          break;
        case 'up':
          _results2 = [];
          for (i = _k = 0; _k <= 3; i = ++_k) {
            newArray = getColumn(i, board);
            newArray = mergeCells(newArray, 'up');
            newArray = collapseCells(newArray, 'up');
            setColumn(newArray, i, board);
            _results2.push(ppArray(board));
          }
          return _results2;
          break;
        case 'down':
          _results3 = [];
          for (i = _l = 3; _l >= 0; i = --_l) {
            newArray = getColumn(i, board);
            newArray = mergeCells(newArray, 'down');
            newArray = collapseCells(newArray, 'down');
            setColumn(newArray, i, board);
            _results3.push(ppArray(board));
          }
          return _results3;
      }
    };
    return ppArray(this.board);
  });

}).call(this);

//# sourceMappingURL=main.map
