Tailspin Toys, or Tailspin for short, is a video game company. Tailspin hosts its game servers and web sites in an on-prem datacenter. The company just celebrated the release of a new racing game. They'll be releasing a space shooter game, called _Space Game_, in the coming months.

The team that you'll be working with builds web sites to support new game titles. These web sites provide information about the game, ways to get it, and leaderboards that show top scores. Each web site must go live the same day the game is released, which requires coordination among the teams and adds a sense of pressure on the web team.

The _Space Game_ web site is a .NET Core app written in C# that's deployed to Linux. The web site isn't finished yet, but here's what it looks like right now.

<!-- TODO: Host this under our team account. -->
<!-- TODO: Throw a fake DNS name in front of this to hide the fact we're hosting it on Azure - the fictitious team isn't there yet. -->

![The Space Game web site](../media-draft/2-space-game-top.png)

And here's what the leaderboard looks like.

![The Space Game leaderboard](../media-draft/2-space-game-leaderboard.png)

You can filter the leaderboard by mode or by game map. You can also click on a player name to see their profile and game achievements.

![The Space Game web site](../media-draft/2-player-profile.png)

> [!NOTE]
> Although the game and the web site aren't yet finished, you can [check out the web site now](http://tailspin-spacegame-web.azurewebsites.net?azure-portal=true) to get a sense of how it works.

Here are your team members.

<!-- TODO: We need final graphics for the team members. -->

<!-- TODO: Fix this layout to make it more pleasing. -->

[!include[](../../shared/includes/meet-andy-row.md)]

[!include[](../../shared/includes/meet-amita-row.md)]

[!include[](../../shared/includes/meet-tim-row.md)]

[!include[](../../shared/includes/meet-irwin-row.md)]

[!include[](../../shared/includes/meet-mara-row.md)]

## Good morning

Irwin, the team's product manager, has called everyone into a meeting and he's in a bad mood. The leaderboard for the racing game was just updated with several new features and he showed it at a Meetup group. Players' reactions were disappointing, to say the least. He reads off a list of the top problems:

* Some features only work correctly for some game modes.
* Updating the leaderboard takes too long, even with a small number of players.
* Multiple scores per player show up as multiple players.
* The new ranking feature returns incorrect results.
* There's no way to group scores according to a specific date or game session.
* It took months to get the new release (and it's broken).

He demands, "How long before these problems are fixed?"

**Andy thinks**: I bet it takes me a month to write that code.

**Amita thinks**: It'll take me at least a week to test this and I can't start until Andy is finished and he always wants to sneak in new code.

**Tim thinks**: It will take me at least a week to set up the environments and deploy this to production. I can't start until Amita is finished and she's never willing to call something a release candidate.

**Mara wonders**: Was taking this job a mistake?

Andy looks around at his team mates and says, "We'll get back to you."
