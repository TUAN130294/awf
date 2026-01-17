# Agentic Framework Patterns - Quick Reference
## For AWF Implementation & Decision Making

---

## Pattern Selection Matrix

### When to Use Each Execution Pattern

| Pattern | Use Case | Latency | Complexity | Example |
|---------|----------|---------|-----------|---------|
| **Sequential** | Dependent tasks, clear order | Baseline | Low | Plan → Code → Test → Review |
| **Parallel** | Independent tasks | 60-80% reduction | Medium | Research + Design + Test simultaneously |
| **Hierarchical** | Team structure, role-based | Medium | Medium | Manager → Specialist Workers |
| **Scatter-Gather** | Complex decomposition | Medium | High | Break complex problem into subtasks |
| **Mixture-of-Agents** | Multi-stage analysis | Medium | High | Layer 1 analysis → Layer 2 synthesis |

---

## Framework Quick Comparison

### LangGraph
```
When: Need explicit control, complex logic, production reliability
Why: Fastest, most deterministic, best debugging
Cost: Higher learning curve
Example: Multi-stage data pipeline with state validation
```

### CrewAI
```
When: Role-based teams, business processes, quick deployment
Why: Simplest API, built-in memory, role intuition
Cost: Less control over state management
Example: Content creation team (Researcher + Writer + Editor)
```

### AutoGen
```
When: Human-in-the-loop, natural conversation, enterprise
Why: Natural interaction, conversation patterns, Microsoft backing
Cost: Less deterministic, can get stuck
Example: Code review with human expert feedback loop
```

---

## Error Handling Decision Tree

```
Error Detected
    ↓
Classify:
├─ Transient (network, timeout, rate limit)
│  └─ Strategy: RETRY (exponential backoff, max 3x)
│
├─ Permanent (bad credentials, invalid input)
│  └─ Strategy: ESCALATE (to human/specialist)
│
├─ Partial (some agents fail, 2/3 data sources)
│  └─ Strategy: DEGRADE (continue with available data)
│
└─ Logic (agent loop, contradiction)
   └─ Strategy: TERMINATE (stop + analyze)
```

---

## Memory Layer Selection

| Layer | Technology | Use Case | TTL | Cost |
|-------|-----------|----------|-----|------|
| **Short-term** | ChromaDB/Vector | Recent interactions | Minutes | Low |
| **Recent Results** | SQLite | Task outputs | Hours | Low |
| **Long-term** | SQLite+Embeddings | Persistent facts | Weeks | Medium |
| **Explicit State** | TypedDict | Current execution | Seconds | Low |

**For AWF:** Extend `/save-brain` to populate all layers. Add TTL config.

---

## Fallback Chain Patterns

### Pattern 1: Tool Fallback
```
Primary Tool → Fails → Secondary Tool → Succeeds
Example: Primary API down → Use cached data
```

### Pattern 2: Model Fallback
```
GPT-4 (expensive) → Complex → Fails → GPT-3.5 (cheap) → Succeeds
Example: Technical task → Simpler explanation → Works
```

### Pattern 3: Format Fallback
```
JSON → Fails → CSV → Succeeds
Example: API returns malformed JSON → Parse as CSV fallback
```

### Pattern 4: Human Fallback
```
Agent → Confidence < 50% → Escalate to Human
Example: Complex decision → Human reviews + approves
```

### Pattern 5: Degradation Fallback
```
Full Feature → Unavailable → Standard Feature → Works
Example: Real-time data unavailable → Use cached data
```

---

## Parallel Execution Checklist

- [ ] **Dependency Analysis:** Verify tasks truly independent
- [ ] **Result Aggregation:** Plan how to combine results
- [ ] **Timeout Strategy:** Set reasonable max time
- [ ] **Partial Failure:** How to handle 2/3 success?
- [ ] **Resource Limits:** Don't spawn too many concurrent tasks
- [ ] **Ordering:** If results order-dependent, map explicitly

**Rule of Thumb:** Parallelize only if tasks are 100% independent and aggregation is simple.

---

## State Schema Template

```json
{
  "version": "3.3",
  "metadata": {
    "created_at": "2026-01-17T10:30:00Z",
    "last_updated": "2026-01-17T10:35:00Z",
    "workflow_id": "..."
  },
  "execution": {
    "phase": "planning|construction|deployment|completed|failed",
    "status": "in_progress|paused|completed",
    "current_task": "task_id",
    "completed_tasks": ["task_1", "task_2"],
    "pending_tasks": ["task_3", "task_4"]
  },
  "context": {
    "project_summary": "...",
    "requirements": "...",
    "decisions": []
  },
  "errors": [
    {
      "timestamp": "...",
      "agent": "...",
      "error_type": "transient|permanent|logic|partial",
      "message": "...",
      "recovery_strategy": "retry|fallback|escalate|terminate",
      "recovery_status": "attempted|succeeded|failed"
    }
  ],
  "metrics": {
    "total_tasks": 10,
    "succeeded": 8,
    "failed": 1,
    "recovery_attempts": 2,
    "recovery_success_rate": 0.75,
    "total_tokens": 50000,
    "estimated_cost": "$0.75",
    "execution_time_seconds": 450
  }
}
```

---

## Timeout & Limits Configuration

```json
{
  "execution_limits": {
    "global_timeout_seconds": 3600,
    "task_timeout_seconds": 300,
    "max_iterations": 10,
    "max_retries": 3,
    "max_parallel_tasks": 5,
    "max_tokens_per_task": 50000,
    "max_tokens_total": 200000
  },
  "backoff_strategy": "exponential",
  "backoff_base_seconds": 2,
  "backoff_max_seconds": 60
}
```

---

## Guardrails Implementation Template

```python
class Guardrail:
    def __init__(self, name: str, check_fn, action: str):
        self.name = name
        self.check_fn = check_fn
        self.action = action  # "block", "warn", "escalate"

guardrails = [
    Guardrail(
        "max_tokens",
        lambda tokens: tokens <= 50000,
        "block"
    ),
    Guardrail(
        "no_destructive_ops",
        lambda operation: operation not in ["delete", "drop", "truncate"],
        "block"
    ),
    Guardrail(
        "requires_approval",
        lambda action: action != "deploy_to_production",
        "escalate"
    ),
]

def validate_before_execution(task, context):
    for guardrail in guardrails:
        if not guardrail.check_fn(context):
            if guardrail.action == "block":
                raise PermissionError(f"Guardrail blocked: {guardrail.name}")
            elif guardrail.action == "escalate":
                notify_human(f"Approval needed: {guardrail.name}")
```

---

## Common Pitfalls & Fixes

| Pitfall | Symptom | Fix |
|---------|---------|-----|
| **Token Explosion** | High costs, OOM | Implement context windowing, summarization |
| **Agent Loops** | Endless conversation | Add max_iterations, termination conditions |
| **Memory Leak** | Growing storage, slowness | Implement TTL, pruning, archival |
| **Over-Parallelization** | Complexity, unclear deps | Only parallelize truly independent tasks |
| **No Error Visibility** | Silent failures | Implement error classification + logging |
| **Implicit State** | Hard to debug | Use TypedDict explicit schemas |
| **Tight Coupling** | Can't reuse agents | Parameterize agent behavior, use composition |

---

## Monitoring Metrics to Track

### Performance Metrics
```
- End-to-end execution time
- Per-agent execution time
- Parallel speedup factor = Sequential Time / Parallel Time
- Agent utilization (% active time)
- Queue depth (waiting tasks)
```

### Reliability Metrics
```
- Success rate (successful tasks / total tasks)
- Error rate (errors / total tasks)
- Recovery success rate (recovered errors / total errors)
- Timeout rate (timeouts / total tasks)
- Human escalation rate (escalated / total tasks)
```

### Cost Metrics
```
- Tokens per task
- Cost per task
- Total cost per workflow
- Cost per agent type
```

### Memory Metrics
```
- Brain file size (bytes)
- Active memory layers (types)
- Cache hit rate
- Pruned records per day
```

---

## Decision Matrix: LangGraph vs CrewAI vs AutoGen

### Feature Comparison
| Feature | LangGraph | CrewAI | AutoGen |
|---------|-----------|--------|---------|
| **State Management** | Excellent | Good | Medium |
| **Ease of Use** | Medium | High | Medium |
| **Performance** | Fastest | Good | Good |
| **Memory Management** | Manual | Built-in | None |
| **Team Roles** | No | Yes | No |
| **Human Interaction** | Via callbacks | Limited | Excellent |
| **Production Ready** | Yes | Yes | Transitioning |
| **Enterprise Support** | No | No | Yes (Microsoft) |

### Quick Selection
- **"I need maximum control"** → LangGraph
- **"I have team roles"** → CrewAI
- **"I need human feedback loops"** → AutoGen
- **"I'm in enterprise"** → AutoGen (moving to Microsoft Agent Framework Q1 2026)

---

## Implementation Checklist (Per Task)

Before implementing any AWF workflow enhancement:

- [ ] **Identify Pattern:** Sequential? Parallel? Hierarchical?
- [ ] **Define State Schema:** What data flows between agents?
- [ ] **Plan Error Cases:** What can go wrong? How to recover?
- [ ] **Set Timeouts:** Max execution time? Max iterations?
- [ ] **Add Guardrails:** What constraints must be enforced?
- [ ] **Design Monitoring:** What metrics matter?
- [ ] **Test Failures:** Run failure scenarios
- [ ] **Document:** Add examples to user guide

---

## Framework Version Reference

**As of January 17, 2026:**

| Framework | Version | Status | Next Version |
|-----------|---------|--------|--------------|
| LangGraph | Stable | Active development | Stable |
| CrewAI | v0.x (stable) | Active development | v1.0 planned |
| AutoGen | 0.2 | Transitioning to Microsoft | Migration by Q1 2026 |
| Microsoft Agent Framework | Beta | Available now | GA Q1 2026 |
| OpenAI Swarm | Experimental | Not for production | Research only |

---

## Resources for Deep Dives

### Official Docs
- LangGraph: https://www.langchain.com/langgraph
- CrewAI: https://docs.crewai.com
- AutoGen: https://microsoft.github.io/autogen/

### Best Practices Guides
- Agentic Workflows 2026: https://www.vellum.ai/blog/agentic-workflows-emerging-architectures-and-design-patterns
- Framework Comparison: https://o-mega.ai/articles/langgraph-vs-crewai-vs-autogen-top-10-agent-frameworks-2026
- Error Handling: https://blog.bytebytego.com/p/top-ai-agentic-workflow-patterns

### Enterprise Guidance
- AWS: https://docs.aws.amazon.com/prescriptive-guidance/latest/agentic-ai-frameworks/crewai.html
- Microsoft: https://learn.microsoft.com/en-us/agent-framework/

---

**Last Updated:** 2026-01-17
**For:** AWF v3.3+ Implementation
**Alignment:** YAGNI, KISS, DRY
