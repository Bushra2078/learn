Reliable, fast, and resilient name resolution is critical for application availability. This unit discusses the design considerations and recommendations for DNS.

## Considerations

Fast and reliable DNS resolution is required for most applications to function well. Azure provides options for built-in name resolution or bring-your-own DNS, or both. Many customers will use a mix of built-in Azure DNS services and bring-your-own DNS.

## Recommendations

If only resolution inside of an Azure virtual network is required, use Azure Private DNS to minimize your operational and administrative effort. For cross-premises resolution, deploy at least two DNS resolvers per Azure region into an Azure virtual network. Configure the virtual networks to use those resolvers. This allows for DNS resolution to not be impacted by latency or be offline because of a single VM failure. Use zone redundant services where available.

Use conditional forwarders with Azure Private DNS so that on premises servers can resolve Azure VMs and PaaS service names.

Enable DNS autoregistration for Azure VMs, so VMs can locate each other by name.
Use an Azure Private DNS zone in the global connectivity subscription. Additional zones might be needed for services such as Private Link. 