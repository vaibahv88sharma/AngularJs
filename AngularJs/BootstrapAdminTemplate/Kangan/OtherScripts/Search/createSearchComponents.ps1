Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue


# Server SPSDC01P-BRO

# STEP - 1   Clone the active search topology
$ssa = Get-SPEnterpriseSearchServiceApplication
$active = Get-SPEnterpriseSearchTopology -SearchApplication $ssa -Active
$clone = New-SPEnterpriseSearchTopology -SearchApplication $ssa -Clone –SearchTopology $active

	#Content Processing Component
		# STEP - 3a-CPC   Add New Search Content Processing Component
		$SPSDC01Pcpc = Get-SPEnterpriseSearchServiceInstance -Identity "SPSDC01P-BRO"
		New-SPEnterpriseSearchContentProcessingComponent -SearchTopology $clone -SearchServiceInstance $SPSDC01Pcpc

		# STEP - 3b-CPC   Start the Search Instance
		Start-SPEnterpriseSearchServiceInstance -Identity $SPSDC01Pcpc

		# STEP - 3c-CPC  Activate the Cloned Search Topology
		Set-SPEnterpriseSearchTopology -Identity $clone

	#Analytics Processing Component
		# STEP - 3a-APC   Add New Search Analytics Processing Component
		$SPSDC01Papc = Get-SPEnterpriseSearchServiceInstance -Identity "SPSDC01P-BRO"
		New-SPEnterpriseSearchAnalyticsProcessingComponent -SearchTopology $clone -SearchServiceInstance $SPSDC01Papc

		# STEP - 3b-APC   Start the Search Instance
		Start-SPEnterpriseSearchServiceInstance -Identity $SPSDC01Papc

		# STEP - 3c-APC  Activate the Cloned Search Topology
		Set-SPEnterpriseSearchTopology -Identity $clone

	#Crawl Processing Component
		# STEP - 3a-APC   Add New Search Crawl Processing Component
		$SPSDC01Pcrawl = Get-SPEnterpriseSearchServiceInstance -Identity "SPSDC01P-BRO"
		New-SPEnterpriseSearchCrawlComponent -SearchTopology $clone -SearchServiceInstance $SPSDC01Pcrawl

		# STEP - 3b-APC   Start the Search Instance
		Start-SPEnterpriseSearchServiceInstance -Identity $SPSDC01Pcrawl

		# STEP - 3c-APC  Activate the Cloned Search Topology
		Set-SPEnterpriseSearchTopology -Identity $clone
		
	#Query Processing Component
		# STEP - 3a-CPC   Add New Query Processing Component
		$SPSDC01Pqpc = Get-SPEnterpriseSearchServiceInstance -Identity "SPSDC01P-BRO"
		New-SPEnterpriseSearchQueryProcessingComponent -SearchTopology $clone -SearchServiceInstance $SPSDC01Pqpc

		# STEP - 3b-CPC   Start the Search Instance
		Start-SPEnterpriseSearchServiceInstance -Identity $SPSDC01Pqpc

		# STEP - 3c-CPC  Activate the Cloned Search Topology
		Set-SPEnterpriseSearchTopology -Identity $clone
		
	#Admin Component
		# STEP - 3a-CPC   Add New Admin Component
		$SPSDC01Padmin = Get-SPEnterpriseSearchServiceInstance -Identity "SPSDC01P-BRO"
		New-SPEnterpriseSearchAdminComponent -SearchTopology $clone -SearchServiceInstance $SPSDC01Padmin

		# STEP - 3b-CPC   Start the Search Instance
		Start-SPEnterpriseSearchServiceInstance -Identity $SPSDC01Padmin

		# STEP - 3c-CPC  Activate the Cloned Search Topology
		Set-SPEnterpriseSearchTopology -Identity $clone
		
	# Clone => Index Component
		# STEP - 3a-CPC   Add New Admin Component
		$SPSDC01Pindex = Get-SPEnterpriseSearchServiceInstance -Identity "SPSDC01P-BRO"
		Start-SPEnterpriseSearchServiceInstance -Identity $SPSDC01Pindex
			# Testing is service is checked
			Get-SPEnterpriseSearchServiceInstance -Identity $SPSDC01Pindex
			
		New-SPEnterpriseSearchIndexComponent -SearchTopology $clone -SearchServiceInstance $SPSDC01Pindex -IndexPartition 0

		# STEP - 3b-CPC   Start the Search Instance
		#Start-SPEnterpriseSearchServiceInstance -Identity $SPSDC01Pindex

		# STEP - 3c-CPC  Activate the Cloned Search Topology
		Set-SPEnterpriseSearchTopology -Identity $clone
				
		
		