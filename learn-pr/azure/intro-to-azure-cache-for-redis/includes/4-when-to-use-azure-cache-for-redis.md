
In this unit, we'll discuss how you can determine if Azure Cache for Redis is a suitable caching solution for your organization. We'll evaluate Azure Cache for Redis against the following criteria:

- Simplicity
- Reliability
- Scaling

## Decision criteria

To determine whether to use Azure Cache for Redis, the following table provides useful criteria.

| Criteria    | Analysis     |
| ------------------------- | ---------------------------- |
| Simplicity | A managed service offers several benefits, including provisioning, setup, scaling, updates, and patching. |
| Reliability | It's vital that any caching solution is highly available. This helps ensure that your apps can deliver at peak performance, even if component failures occur. |
| Scaling | It's important that the system can respond to changes in load. Scaling should be automatic and occur without downtime. |

## Apply the criteria

Review the following questions when considering Azure Cache for Redis as your data-integration solution.

### Do you want a managed service approach?

When you use Azure Cache for Redis, you're implementing a fully managed service. This provides many benefits, including:

- Automatically managed patching, updates, provisioning, configuration, setup, and scaling.
- Implementation of Azure Monitor to track parameters and metrics within the cache, infrastructure, and network.
- Use of any Redis client to connect to the service.

### Is reliability critical?

Azure Cache for Redis provides several reliability and high-availability features, including OSS Cluster, data persistence, zone redundancy, and geo-replication.

Specifically, Azure Cache for Redis has several high-availability capabilities, including that it:

- Includes a redundant pair of VMs configured for automatic failover.

   > [!NOTE]
   > This excludes Basic tier.

- Provides up to 99.999% availability in the Enterprise tiers.
- Supports a zone-redundant configuration.
- Supports active geo-replication to create global caches that have local latency across regions.

### Do you anticipate sudden changes in load?

It's important that the system can respond to changes in load. Sudden changes in demand might occur when you run sales promotions or at specific times of the year. Azure Cache for Redis provides automatic scaling that occurs without downtime.

## Summary

In summary, consider implementing Azure Cache for Redis when you:

- Want to implement an app-caching solution that's based on industry standard technologies.
- Don't want to worry about underlying VMs or infrastructure and want the simplicity of a fully managed service.
- Consider high availability critical to your organization's business goals.
- Want a system that can respond automatically to both anticipated and unanticipated changes in demand.
- Need the same performance and scaling benefits throughout the world.

When you're deciding which tier to select, you should choose the:

- Basic or Standard tiers only for noncritical workloads.
- Premium or Enterprise tiers when you require more performance.
- Enterprise tiers when you:

  - Need higher availability than the Premium tier offers.
  - Require RedisBloom, RediSearch, and RedisTimeSeries module integration.

- Enterprise Flash tier when you want to reduce costs by using nonvolatile memory.
