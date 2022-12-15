exec function showenvs()
{
	var envs : array< string >;
	var i : int;

	GetActiveAreaEnvironmentDefinitions( envs );
	for(i = 0; i < envs.Size(); i += 1)
	{
		theGame.witcherLog.AddMessage(envs[i]);
	}
}