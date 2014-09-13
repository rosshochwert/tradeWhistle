


var league = {};
var tempPlayer = {
    "position": "RB", 
    "projected": 15,
    "prk": 5,
    "owned": .123
}
var teams = ["Team 1", "Team 2", "Team 3", "Team 4", "Team 5", "Team 6", "Team 7", "Team 8", "Team 9", "Team 10"];
teams.forEach(function(team){
    league[team] = {};
    for(i = 0; i <= 14; i++){
        var player = "Player"+i;
        league[team][player] = tempPlayer;
    }
})


var height = 540;

var team_canvas = d3.select(".cur-team")
        .style('padding', 10)
        .append("svg")
            .attr("width", "100%")
            .attr('height', 540);

var rectHeight = 36;

console.log(d3.entries(league['Team 1']));

var roster = team_canvas.selectAll('g')
        .data(d3.entries(league['Team 1'])).enter()
        .append('g')
            .attr("transform", function(d, i) { return "translate(0," + i * rectHeight + ")"; });

roster.append('rect')
    .style("stroke", "#000")
    .style("stroke-width", 2)
    .attr('class', 'roster-spot')
    .attr('fill', '#b9b7b7')
    .attr('width', '100%')
    .attr('height', rectHeight);

roster.append('text')
    .attr("x", 40)
    .attr("y", rectHeight / 2)
    .attr("dy", ".35em")
    .text(function(d){
                return d.value.position +" | " + d.key;
            });
        


