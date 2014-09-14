$( document ).ready(function() {

var league = {};

var qbs =["Matt Ryan","Matthew Stafford","Andrew Luck","Peyton Manning","Carson Palmer","Jake Locker","Derek Anderson","Andy Dalton","Jay Cutler","Colin Kaepernick","Russell Wilson","Ben Roethlisberger","Chad Henne","Drew Brees","Joe Flacco","EJ Manuel","Matt Cassel","Nick Foles","Derek Carr","Josh McCown","Ryan Fitzpatrick","Brian Hoyer","Ryan Tannehill","Philip Rivers","Geno Smith","Tony Romo","Alex Smith","Aaron Rodgers","Robert Griffin","Eli Manning","Austin Davis","Shaun Hill","Jon Kitna","Matt Hasselbeck","Michael Vick",];
var rbs =["Marshawn Lynch","Knowshon Moreno","Mark Ingram","DeMarco Murray","Matt Forte","Chris Ivory","Rashad Jennings","Isaiah Crowell","Darren Sproles","Chris Johnson","Justin Forsett","Montee Ball","C.J. Spiller","Ryan Mathews","Shane Vereen","LeSean McCoy","Antone Smith","Joique Bell","Carlos Hyde","Lamar Miller","Giovani Bernard","Terrance West","Arian Foster","Jacquizz Rodgers","Alfred Morris","Adrian Peterson*","Ahmad Bradshaw","Pierre Thomas","Stepfan Taylor","Khiry Robinson","DeAngelo Williams","Fred Jackson","Shonn Greene","Derrick Coleman","Frank Gore","John Kuhn","Darrel Young","Anthony Dixon","LeGarrette Blount","Steven Jackson","Reggie Bush","Jorvorskie Lane","Toby Gerhart","Roy Helu","Trent Richardson","Bobby Rainey","Andre Ellington","Benjamin Cunningham","Ben Tate*","James Starks","Eddie Lacy","Zac Stacy","Leon Washington","Jonathan Stewart","Dexter McCluster","Maurice Jones-Drew","Jamaal Charles","Jonathan Dwyer","Stevan Ridley","Robert Turbin","Lance Dunbar","C.J. Anderson","Bishop Sankey","Devonta Freeman","Darren McFadden","Mike Tolbert","Matt Asiata","Jeremy Hill","Willis McGahee","Greg Jones","Vonta Leach","Ronnie Brown","Brandon Jacobs","Michael Robinson","Montell Owens","Brian Leonard","Michael Bush","Le'Ron McClain","Jason Snelling","Jackie Battle","Felix Jones","Rashard Mendenhall","Ray Rice","Tashard Choice","Jerome Felton","Jalen Parmele","Spencer Larsen","Lex Hilliard","Peyton Hillis","Jed Collins","Marcel Reece","BenJarvus Green-Ellis","Darius Reynaud","Kahlil Bell","Donald Brown","Andre Brown","Tony Fiammetta","Mike Goodson"];
var wrs =["Allen Hurns","A.J. Green","Cordarrelle Patterson","Steve Smith Sr.","Antonio Brown","Jeremy Maclin","Kelvin Benjamin","DeAndre Hopkins","Brandin Cooks","Roddy White","Mike Wallace","Malcom Floyd","Greg Jennings","Brandon Marshall","Julian Edelman","Randall Cobb","Michael Floyd","Terrance Williams","Kendall Wright","Rod Streater","Reggie Wayne","Andre Johnson","Anquan Boldin","Devin Hester","Marques Colston","James Jones","Percy Harvin","Hakeem Nicks","Golden Tate","Julio Jones","Ricardo Lockette","Brian Quick","Travis Benjamin","Markus Wheaton","Donnie Avery","Jordy Nelson","Emmanuel Sanders","Andrew Hawkins","Chris Owusu","John Brown","Pierre Garcon","Eric Decker","Alshon Jeffery","Robert Woods","DeSean Jackson","Harry Douglas","Justin Hunter","Marqise Lee","Nate Washington","Dez Bryant","Torrey Smith","Dwayne Harris","Mohamed Sanu","Demaryius Thomas","T.Y. Hilton","Cole Beasley","Jerricho Cotchery","Vincent Jackson","Stevie Johnson","Dexter McCluster","Mike Williams","Jeremy Kerley","Kamar Aiken","Chris Givens","Mike Brown","Tavon Austin","Keenan Allen","Justin Brown","Kenbrell Thompkins","Sammy Watkins","Mike Evans","Jordan Matthews","Larry Fitzgerald","Santonio Holmes","Miles Austin","Ted Ginn Jr.","Eddie Royal","Michael Crabtree","Brian Hartline","Riley Cooper","Andre Roberts","Victor Cruz","Jerrel Jernigan","Jarius Wright","Frankie Hammond","Jacoby Jones","Andre Caldwell","Danny Amendola","Brandon Tate","David Alan Nelson","Greg Salas","Doug Baldwin","Jeff Maehl","Devin Street","Taylor Gabriel","Brandon Stokley","Plaxico Burress","Santana Moss","Nate Burleson"];
var tes =["Julius Thomas","Vernon Davis","Greg Olsen","Martellus Bennett","Zach Ertz","Dwayne Allen","Larry Donnell","Rob Gronkowski","Delanie Walker","Antonio Gates","Anthony Fasano","Dennis Pitta","Jimmy Graham","Kyle Rudolph","Levine Toilolo","Niles Paul","Jared Cook","Jeff Cumberland","Zach Miller","Brandon Myers","Jordan Cameron","Travis Kelce","Joseph Fauria","Marcedes Lewis","Owen Daniels","Jim Dray","Tyler Eifert*","Mychal Rivera","Heath Miller","John Carlson","Andrew Quarless","Charles Clay","Coby Fleener","Ladarius Green","Rhett Ellison","Taylor Thompson","Austin Seferian- Jenkins*","Jason Witten","Dante Rosario","Brent Celek","Gary Barnidge","Jermaine Gresham","Lance Kendricks","Rob Housler","Tim Wright","Brian Leonhardt","Tony Gonzalez","Dallas Clark","Visanthe Shiancoe","Kellen Winslow"];
var dsts =["Chicago Bears","Arizona Cardinals","Green Bay Packers","New York Giants","Detroit Lions","Washington Redskins","Pittsburgh Steelers","Philadelphia Eagles","St. Louis Rams","San Francisco 49ers","Cleveland Browns","Indianapolis Colts","Dallas Cowboys","Oakland Raiders","New England Patriots","Tennessee Titans","Denver Broncos","San Diego Chargers","New York Jets","Kansas City Chiefs","Buffalo Bills","Minnesota Vikings","Miami Dolphins","Atlanta Falcons","New Orleans Saints","Cincinnati Bengals","Seattle Seahawks","Tampa Bay Buccaneers","Jacksonville Jaguars","Carolina Panthers","Baltimore Ravens","Houston Texans"];
var ks =["Matt Bryant","Mike Nugent","Ryan Succop","Caleb Sturgis","Shaun Suisham","Dan Carpenter","Blair Walsh","Shayne Graham","Cody Parkey","Stephen Gostkowski","Steven Hauschka","Billy Cundiff","Robbie Gould","Nick Folk","Greg Zuerlein","Nate Freese","Graham Gano","Chandler Catanzaro","Brandon McManus","Adam Vinatieri","Randy Bullock","Nick Novak","Dan Bailey","Josh Scobee","Mason Crosby","Phil Dawson","Justin Tucker","Cairo Santos","Sebastian Janikowski","Josh Brown","Patrick Murray","David Akers","Rian Lindell"];

function draftpos(round){
	var pos = "";
	var poslist;
	if(round <= 2){
		pos = "QB";
		poslist = qbs;
	} else if (round <= 6){
		pos = "RB";
		poslist = rbs;
	} else if (round <= 11){
		pos = "WR";
		poslist = wrs;
	} else if (round <= 13){
		pos = "TE";
		poslist = tes;
	} else if (round <= 14){
		pos = "DST";
		poslist = dsts;
	} else {
		pos = "K";
		poslist = ks;
	}

	var picknum = Math.floor((Math.random() * poslist.length));
	var name = poslist[picknum];
    poslist.splice(picknum,1);
	var projected = Math.random() * 25;
	var owned = Math.random();

	var player = {
		"name": name,
		"position": pos,
		"projected": projected,
		"prk": picknum,
		"owned": owned
	}

	return player;
}

var teamsRoss;

$.ajax({
            type: "GET",
            contentType: "application/json; charset=utf-8",
            url: '/teams.json',
            dataType: 'json',
            success: function (received_data) {
               teamsRoss = received_data;
            },
            error: function (result) {
            }
    });

var teams = ["Team 1", "Team 2", "Team 3", "Team 4", "Team 5", "Team 6", "Team 7", "Team 8", "Team 9", "Team 10"];

teamsRoss.forEach(function(team){
    league[team] = [];
    for(i = 1; i <= 15; i++){
        var draftee = draftpos(i);
        league[team].push(draftee);
        console.log(draftee);
    }
});

var projectedScores = [],
    prk = [],
    percentOwned =[];

for(var team in league){
    for(var player in league[team]){ 
        projectedScores.push(league[team][player]['projected']);
        prk.push(league[team][player]['prk']);
        percentOwned.push(league[team][player]['owned']);
    }
};

var height = 540;

var opp_roster,
    opp_rosterRect,
    opp_rosterText;

var team_canvas = d3.select(".cur-team")
        .append("svg")
            .attr("width", "100%")
            .attr('height', 540);

var rectHeight = 36,
    smallHeight = 15;

var valueScale = d3.scale.quantize()
    .domain(d3.extent(percentOwned))
    .range(['#109510','#31ff3a','#f7d129', '#faed00','#de6905','#f70000']);


var roster = team_canvas.selectAll('g')
        .data(league['Team 1']).enter()
        .append('g')
            .attr("class", "groups")
            .attr("transform", function(d, i) { return "translate(0," + i * rectHeight + ")"; });

var rosterRect = roster.append('rect')
    .attr('class', 'roster-spot')
    .attr('fill', function(d){
        return valueScale(d.owned);
    })
    .attr('width', '100%')
    .attr('height', rectHeight);

var rosterText = roster.append('text')
    .attr("x", 10)
    .attr("y", rectHeight / 2)
    .attr("dy", ".35em")
    .text(function(d){
                return d.position +" | " + d.name;
            });

var opponent_canvas = d3.select(".opp-team")
    .append("svg")
        .attr("width", "100%")
        .attr("height", 540);

for (var key in league){
   var tempCanvas = d3.select(".league")
        .append('div')
            .style('margin', '5px')
            .attr('class', 'col-md-2 small-team')
            .attr('name', key);
   
   tempCanvas.append('span')
        .text(key);
    
    tempCanvas.append('br');
    
    var tempSVG = tempCanvas.append('svg')
                .attr("width", "100%")
                .attr('height', 250);
    
    var tempRoster = tempSVG.selectAll('g')
        .data(league[key]).enter()
        .append('g')
            .attr("transform", function(d, i) { return "translate(0," + i * smallHeight + ")"; });
    
    tempRoster.append('rect')
        .attr('class', 'small-spot')
        .attr('fill', function(d){
            return valueScale(d.owned);
        })
        .attr('width', '100%')
        .attr('height', smallHeight);
    
    tempRoster.append('text')
        .attr('x', 5)
        .attr('y', smallHeight/2)
        .attr('dy', '.35em')
        .text(function(d){
            return d.position;
        });
    
}


$('.metric').click(function(){
    if($(this).attr('value') == "projected"){
        console.log("projected");
        valueScale.domain(d3.extent(projectedScores));
    }
    if($(this).attr('value') == "prk"){
        console.log("prk");
        valueScale.domain(d3.extent(prk));
    }
    if($(this).attr('value')=="owned"){
        console.log("owned");
        valueScale.domain(d3.extent(percentOwned));
    }
});



$('.small-team').click(function(){
    populateOpponent($(this).attr('name'));
});

function populateOpponent(team){
    if($('.opp-spot').length>0){
        opp_roster.remove();
        createOppRoster(team);
    }else{
        createOppRoster(team);
    }
}

function createOppRoster(team){
    opp_roster = opponent_canvas.selectAll('g')
            .data(league[team]).enter()
            .append('g')
                .attr('class', 'groups')
                .attr("transform", function(d, i) { return "translate(0," + i * rectHeight + ")"; });
        
        opp_rosterRect = opp_roster.append('rect')
                .attr('class', 'opp-spot')
                .attr('fill', function(d){
                    return valueScale(d.owned);
                })
                .attr('width', '100%')
                .attr('height', rectHeight);
        
        opp_rosterText = opp_roster.append('text')
                .attr("x", 10)
                .attr("y", rectHeight / 2)
                .attr("dy", ".35em")
                .text(function(d){
                            return d.position +" | " + d.name;});

}

$(".sort").click(function(){
    var transition = team_canvas.transition().duration(750);
    var opp_transition = opponent_canvas.transition().duration(750);
    
    roster.sort(function(a,b){ return a.owned-b.owned;});
    opp_roster.sort(function(a,b){ return a.owned-b.owned;});
    
    transition.selectAll('.groups')
        .attr("transform", function(d, i) { return "translate(0," + i * rectHeight + ")"; });
    
    opp_transition.selectAll('.groups')
        .attr("transform", function(d, i) { return "translate(0," + i * rectHeight + ")"; });
});

/*var league_canvas = d3.select(".league")
        .selectAll('div')
        .data(d3.entries(league)).enter()
        .append('div')
            .style('margin', '5px')
            .attr('class', 'col-md-2')*/
});

