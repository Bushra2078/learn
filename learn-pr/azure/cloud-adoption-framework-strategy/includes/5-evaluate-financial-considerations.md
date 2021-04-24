Measuring objectives helps provide a financial consideration by defining the return expected from a specific effort. Cost is another key financial consideration. In this unit, we explore various outcome-driven considerations and a few formulas to calculate costs.

## Sample outcomes by category

Speaking in terms of business outcomes can feel like a foreign language to many technical-minded individuals. To help ease translation, we've curated a set of examples of business outcome. You can use the following examples to inspire and demonstrate business outcomes that are based on actual transformation journeys.

To help you find specific types of examples of business outcomes, we've separated our list of examples into categories. This approach tends to drive consensus-building conversations across business units.

### Fiscal outcomes

Financial or fiscal performance is the cleanest business outcome for many business leaders, but it's not the only one.

View samples of [fiscal outcomes](https://docs.microsoft.com/azure/cloud-adoption-framework/strategy/business-outcomes/fiscal-outcomes?azure-portal=true).

### Agility outcomes

Today's fast-changing business environment places a premium on time. The ability to respond to and drive market change quickly is the fundamental measure of business agility.

View samples of [agility outcomes](https://docs.microsoft.com/azure/cloud-adoption-framework/strategy/business-outcomes/agility-outcomes?azure-portal=true).

<!-- docutune:ignore "global reach" -->

### Reach outcomes

In a constantly shrinking market, global reach (the ability to support global customers and users) can be measured by compliance in geographies that are relevant to the business.

View outcomes related to [global reach](https://docs.microsoft.com/azure/cloud-adoption-framework/strategy/business-outcomes/reach-outcomes?azure-portal=true).

### Customer engagement outcomes

Social marketplaces are redefining winners and losers at an unheard-of pace. Responding to user needs is a key measure of customer engagement.

Learn more about [customer engagement outcomes](https://docs.microsoft.com/azure/cloud-adoption-framework/strategy/business-outcomes/engagement-outcomes?azure-portal=true).

### Performance outcomes

Performance and reliability are assumed. When either falters, reputation damage can be painful and long-lasting.

Learn more about [performance outcomes](https://docs.microsoft.com/azure/cloud-adoption-framework/strategy/business-outcomes/performance-outcomes?azure-portal=true).

### Sustainability goals

Organizations are increasingly discussing environmental goals and sustainability targets.

Learn more about [sustainability goals](https://docs.microsoft.com/azure/cloud-adoption-framework/strategy/business-outcomes/sustainability?azure-portal=true).

## Create a financial model for cloud transformation

Creating a financial model that accurately represents the full business value of any cloud transformation can be complicated. Financial models and business justifications tend to vary for different organizations. This unit establishes some formulas and points out a few things that often are missed when strategists create financial models.

## Return on investment

Return on investment (ROI) often is an important criteria for the C-suite or the board of directors. ROI is used to compare different ways to invest limited capital resources. The formula for ROI is fairly simple. The details you'll need to create each input to the formula might not be as simple, though. Essentially, ROI is the amount of return produced from an initial investment. ROI usually is represented as a percentage:

:::image type="content" source="../media/formula-roi.png" alt-text="Image of a math equation that shows that R O I equals gain from investment minus cost of investment divided by cost of investment." border="false":::

In the next sections, we'll walk through the data you'll need to calculate the initial investment and the gain from investment (earnings).

### Calculate initial investment

Initial investment is the capital expense and the operating expense that's required to complete a transformation. The classification of costs can vary depending on accounting models and CFO preference. But this category includes items like professional services that are required to complete the transformation, software licenses used only during the transformation, the cost of cloud services during the transformation, and potentially the cost of salaried employees during the transformation.

Add these costs to create an estimate of the initial investment.

### Calculate the gain from investment

Calculating the gain from investment often requires a second formula that's specific to the business outcomes and associated technical changes. Calculating earnings is harder than calculating cost reductions.

To calculate earnings, you need two variables:

- Changes (deltas) in revenue.
- Changes in costs.

:::image type="content" source="../media/formula-gain-from-investment.png" alt-text="Image of a math equation that shows that gain from investment equals revenue deltas plus cost deltas." border="false":::

These variables are described in the following sections.

### Revenue deltas

Revenue deltas should be forecast in partnership with business stakeholders. After the business stakeholders agree on a revenue impact, the agreement can be used to improve the earnings position.

### Cost deltas

Cost deltas are the increase or decrease in costs that will be caused by the transformation. Independent variables can affect cost deltas. Earnings largely are based on hard costs like capital expense reductions, cost avoidance, operational cost reductions, and depreciation reductions. The following sections describe some cost deltas to consider.

#### Depreciation reduction or acceleration

For guidance on depreciation, speak with the CFO or finance team. The following information is meant to serve as a general reference on the topic of depreciation.

When capital is invested in the acquisition of an asset, that investment might be used for financial or tax purposes to produce ongoing benefits over the expected lifespan of the asset. Some companies see depreciation as a positive tax advantage. Others see it as a committed, ongoing expense that's similar to other recurring expenses attributed to the annual IT budget.

Speak with the finance office to find out whether eliminating depreciation is possible and whether the depreciation elimination would make a positive contribution to cost deltas.

#### Physical asset recovery

In some cases, retired assets can be sold as a source of revenue. This revenue often is lumped into cost reduction for simplicity. But selling retired assets truly can be an increase in revenue, and the revenue can be taxed. Speak with the finance office to understand the viability of this option and how to account for the resulting revenue.

#### Operational cost reductions

Recurring expenses that are required to operate a business often are called operating expenses. This category is broad. In most accounting models, this expense category includes:

- Software licensing.
- Internet hosting expenses.
- Electric bills.
- Real estate rentals.
- Cooling expenses.
- Temporary staff required for operations.
- Equipment rentals.
- Replacement parts.
- Maintenance contracts.
- Repair services.
- Business continuity and disaster recovery (BCDR) services.
- Other expenses that don't require capital expense approvals.

This category provides one of the highest earning deltas. When you're considering a cloud migration, time invested in making this list exhaustive rarely is wasted. Ask the CIO and finance team questions to ensure that all operational costs are accounted for.

#### Cost avoidance

When an operating expenditure is expected but not yet in an approved budget, the expenditure might not fit into a cost reduction category. For example, if VMware and Microsoft licenses need to be renegotiated and paid next year, they aren't fully qualified costs yet. Reductions in those expected costs are treated like operational costs for the sake of cost delta calculations. Informally, however, they should be referred to as cost avoidance until negotiation and budget approval is complete.

#### Soft-cost reductions

At some companies, soft costs like reductions in operational complexity or reductions in full-time staff for operating a datacenter might also be included in cost deltas. But including soft costs might not be a good idea. When you include soft-cost reductions, you insert an undocumented assumption that the reduction will create tangible cost savings. Technology projects rarely result in actual soft-cost recovery.

#### Headcount reductions

Time savings for staff often are included in soft-cost reductions. When those time savings map to actual reductions in IT salary or staffing, they might be calculated separately as headcount reductions.

That said, skills that are needed to work on-premises generally map to a similar (or higher-level) skill set that's needed to work in the cloud. So, people generally aren't laid off after a cloud migration.

An exception occurs when operational capacity is provided by a third party or a managed services provider (MSP). If IT systems are managed by a third party, the operating costs could be replaced by a cloud-native solution or cloud-native MSP. A cloud-native MSP likely will operate more efficiently and potentially at a lower cost. If that's the case, operational cost reductions belong in hard-cost calculations.

#### Capital expense reductions or avoidance

Capital expenses are slightly different from operating expenses. Generally, this category is driven by refresh cycles or datacenter expansion. A datacenter expansion example is the cost of a new high-performance cluster to host a big data solution or data warehouse. This expense  generally would fit into a capital expense category. 

More common are basic equipment refresh cycles. Some companies have rigid hardware refresh cycles, which means that assets are retired and replaced on a regular cycle (usually every three, five, or eight years). These cycles often coincide with asset lease cycles or with the forecasted life span of equipment. In a new refresh cycle, IT draws on capital expense to acquire new equipment.

If a refresh cycle is approved and budgeted, a cloud transformation might help eliminate that cost. If a refresh cycle is planned but not yet approved, the cloud transformation might avoid a capital expenditure. Both reductions would be added to the cost delta.

## Record your observations

If you haven't already, download the [Cloud Adoption Framework strategy and plan template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/plan/cloud-adoption-framework-strategy-and-plan-template.docx?azure-portal=true). Under **Business justification**, use the financial considerations that are discussed in this unit to describe your business justification or financial considerations.
