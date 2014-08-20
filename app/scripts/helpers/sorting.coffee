module.exports =
  
  noVote: (a, b) ->
    b.demAbs + b.repAbs - a.demAbs + a.repAbs

  mostVote: (a, b) ->
    a.demAbs + a.repAbs - b.demAbs + b.repAbs
  
  democratTotal: (a, b) ->
    b.demY - a.demY
  
  republicanTotal: (a, b) ->
    b.repY - a.repY
  
  democratDiff: (a, b) ->
    (b.demY / b.repY) - (a.demY / a.repY)
  
  republicanDiff: (a, b) ->
    (b.repY / b.demY) - (a.repY / a.demY)
  
  newestFirst: (a, b) ->
    a.number - b.number
  
  oldestFirst: (a, b) ->
    b.number - a.number


  sortBy: (item, sortFunc) ->
    item
      .selectAll 'g.amdt-bar'
      .sort sortFunc
      .transition()
      .delay 200
      .duration 500
      .attr 'transform', (d, i) ->
        'translate(' + 0 + ',' + i * 15 + ')'