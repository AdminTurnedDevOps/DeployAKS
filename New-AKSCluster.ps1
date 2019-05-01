function New-AKSCluster {
    [cmdletbinding(DefaultParameterSetName = 'newaks', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory,
            Position = 0,
            ParameterSetName = 'newaks')]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [Parameter(Mandatory,
            Position = 1,
            ParameterSetName = 'newaks')]
        [ValidateNotNullOrEmpty()]
        [string]$resourceGroup,

        [Parameter(Position = 2,
            ParameterSetName = 'newaks')]
        [ValidateNotNullOrEmpty()]
        [string]$Region = "eastus",

        [Parameter(Position = 3,
            ParameterSetName = 'newaks')]
        [ValidateNotNullOrEmpty()]
        [string]$k8sVersion = "1.13.5",

        [Parameter(Position = 4,
            ParameterSetName = 'newaks')]
        [ValidateNotNullOrEmpty()]
        [string]$nodeCount = '2',

        [Parameter(Position = 5,
            ParameterSetName = 'newaks')]
        [ValidateNotNullOrEmpty()]
        [string]$sshPubKey = ''

    )

    begin { Write-Output 'Beginning Cluster Creation'}

    process {
        try:
            $AKSParams = @{
                'Name'              = $Name
                'ResourceGroupName' = $resourceGroup
                'Location'          = $Region
                'KubernetesVersion' = $k8sVersion
                'NodeCount'         = $nodeCount
                'SshKeyValue'       = $sshPubKey
            }

            if ($PSCmdlet.ShouldProcess($Name)) {
                New-AzAks @AKSParams
            }

        catch:
            Write-Warning 'An error has occured'
            $PSCmdlet.ThrowTerminatingError($_)
            exit
    }
    
    end { }

}#Function

# RUN;
# New-AKSCluster -Name 'newclus' -resourceGroup 'AKSTest' -Region 'eastus
