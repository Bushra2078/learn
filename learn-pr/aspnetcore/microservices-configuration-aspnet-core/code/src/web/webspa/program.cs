public class Program
{
    public static Task Main(string[] args) =>
        CreateHostBuilder(args).Build().RunAsync();

    #region snippet_CreateHostBuilder
    private static IHostBuilder CreateHostBuilder(string[] args) =>
        Host.CreateDefaultBuilder(args)
            .ConfigureWebHostDefaults(webBuilder => webBuilder.UseStartup<Startup>())
            .UseContentRoot(Directory.GetCurrentDirectory())
            .ConfigureAppConfiguration((_, configBuilder) =>
            {
                var settings = configBuilder.Build();

                if (settings.GetValue<bool>("UseFeatureManagement") &&
                    !string.IsNullOrEmpty(settings["AppConfig:Endpoint"]))
                {
                    configBuilder.AddAzureAppConfiguration(configOptions =>
                    {
                        configOptions.Connect(settings["AppConfig:Endpoint"])
                                     .UseFeatureFlags();
                    });
                }
            })
            // code omitted for brevity
    #endregion snippet_CreateHostBuilder
            .ConfigureLogging((hostingContext, logBuilder) =>
            {
                logBuilder.AddConfiguration(hostingContext.Configuration.GetSection("Logging"));
                logBuilder.AddConsole();
                logBuilder.AddDebug();
                logBuilder.AddAzureWebAppDiagnostics();
            })
            .UseSerilog((builderContext, config) =>
            {
                config
                    .MinimumLevel.Information()
                    .Enrich.FromLogContext()
                    .WriteTo.Seq("http://seq")
                    .ReadFrom.Configuration(builderContext.Configuration)
                    .WriteTo.Console();
            });
}