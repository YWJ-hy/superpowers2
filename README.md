# Compound Engineering Workflow Framework

这是基于 Superpowers fork 改造后的公司级工程工作流框架。

它的目标不是只服务前端，而是为公司所有项目提供一套统一的 agent 协作框架：
- 先设计
- 再规划
- 再执行
- 最后沉淀可复用经验

当前版本已经支持：
- frontend standards corpus
- backend standards corpus
- shared standards corpus
- repo-local project playbook
- progressive disclosure task packets
- compound engineering compounding step

## Framework Docs

- [WORKFLOW-TLDR.md](WORKFLOW-TLDR.md) — 一页纸版本，适合首次 onboarding
- [WORKFLOW-MINDMAP.md](WORKFLOW-MINDMAP.md) — 完整版，包含流程图、知识分层图、渐进式披露与 compound 机制说明

---

## 本 fork 相比原始 Superpowers 的改造内容

这次改造不是简单增加几个 skill，而是把原来的 workflow 升级成了“公司级知识驱动工作流”。

### 1. 引入 company standards 体系
新增：

```text
docs/company-standards/
  frontend/
  backend/
  shared/
```

作用：
- 存放公司级、跨项目可复用的长期工程规范
- 用稳定 ID 引用，例如：
  - `FE-COMP-001`
  - `BE-API-001`
  - `SH-TEST-001`

这些标准不再只是文档，而是会进入：
- feature spec
- implementation plan
- task packet
- subagent prompt
- review workflow

### 2. 引入 project playbook 体系
新增：

```text
docs/project-playbook/
```

作用：
- 存放当前仓库独有的经验、坑点、legacy constraints、集成限制
- 与 company standards 分层
- 用稳定 ID 引用，例如：
  - `PRJ-PIT-001`
  - `PRJ-PAT-001`
  - `PRJ-LEG-001`

这层知识不会错误提升为公司通用规则。

### 3. 把 brainstorming 升级成 layered spec + 映射入口
`skills/brainstorming/SKILL.md` 现在不只负责讨论设计，还会要求：
- 分层输出 design sections
- 映射 `Applicable Standards`
- 映射 `Applicable Project Notes`
- 以渐进式披露方式给人类展示内容

### 4. 把 writing-plans 升级成 task packet 生成器
`skills/writing-plans/SKILL.md` 现在会让每个任务携带 compact packet，包括：
- Goal
- Spec Sections
- Applicable Standards
- Standards Excerpts
- Applicable Project Notes
- Project Note Excerpts
- Constraints / Non-goals
- Acceptance Checks
- Verification

也就是说，plan 不再只是任务清单，而是“执行上下文包”。

### 5. 把 subagent-driven-development 升级成 excerpt-driven execution
`skills/subagent-driven-development/` 相关 prompt 已改造为：
- implementer 拿到完整 task + relevant excerpts
- spec reviewer 检查 task compliance + standards/project-note compliance
- code-quality reviewer 检查实现是否以干净方式满足这些约束

子代理默认不再需要读取整套 standards corpus，而只接收当前任务需要的摘录。

### 6. 新增 compound-engineering skill
新增：

```text
skills/compound-engineering/SKILL.md
```

作用：
- 编排现有 workflow，而不是替代它
- 在流程末尾输出 `Compound Candidates`
- 建议哪些经验应：
  - Promote to Company Standards
  - Add to Project Playbook
  - Keep in Feature Spec / Plan Only

### 7. 为未来 private overlay 预留扩展点
当前 v1 默认使用 repo-local corpora：
- `docs/company-standards/...`
- `docs/project-playbook/...`

但 workflow 内部已经尽量使用：
- standards corpus
- project-notes corpus

这样的抽象语义，为后续切到 private overlay（方案 C）预留了空间。

---

## 当前框架结构

```text
docs/
  company-standards/
    README.md
    index.md
    frontend/
    backend/
    shared/

  project-playbook/
    README.md
    index.md
    pitfalls.md
    patterns.md
    legacy-constraints.md

  superpowers/
    specs/
    plans/
```

### 各层职责

#### `docs/company-standards/`
公司级、多项目、多域长期标准。

适合放：
- frontend 组件/hook/state/testing 规则
- backend API/service/data/testing/observability 规则
- shared testing/security/architecture/rollout 规则

#### `docs/project-playbook/`
当前项目专属经验层。

适合放：
- 项目坑点
- legacy constraints
- vendor/integration quirks
- 项目内验证过的本地模式

#### `docs/superpowers/specs/`
单次 feature 的设计文档。

#### `docs/superpowers/plans/`
单次 feature 的执行计划与 task packets。

---

## 当前框架如何工作

### Step 1: Brainstorming
用户提出需求后，先通过 `brainstorming` 形成 layered design。

在这个阶段，框架会：
- 讨论需求目标与边界
- 分段展示设计内容
- 标记 applicable standards
- 标记 applicable project notes

### Step 2: Writing Plans
设计确认后，通过 `writing-plans` 生成 implementation plan。

每个任务会绑定：
- spec sections
- standards IDs
- standards excerpts
- project-note IDs
- project-note excerpts
- constraints / acceptance checks

### Step 3: Subagent-Driven Development
执行时，通过 `subagent-driven-development`：
- implementer 只拿任务相关上下文
- spec reviewer 先审 requirements / standards / project notes
- code-quality reviewer 再审结构与实现质量

### Step 4: Compound Engineering
完成后，用 `compound-engineering` 做经验分流：
- 上升为 company standards
- 沉淀进 project playbook
- 还是只留在当前 spec/plan

---

## Claude Code 接入方法

当前框架发布到 GitHub 后，推荐通过 Claude Code 的插件方式接入。

### 方式一：从 marketplace 安装（推荐）

当这个仓库被注册到可访问的 Claude Code marketplace 后，团队成员可以在 Claude Code 中执行：

```text
/plugin marketplace add YWJ-hy/superpowers2
/plugin install superpower2-compound-plugin@superpower2-compound
```

安装完成后，在任意项目目录启动 Claude Code 即可使用当前框架。

### 方式二：本地插件目录加载（开发 / 调试用）

如果你在本地开发这个框架，或者还没有正式发布到 marketplace，可以直接从本地目录加载：

```bash
cd /path/to/your-project
cc --plugin-dir /path/to/this-framework-repo
```

这个模式适合：
- 开发插件本身
- 验证新 skill / standards / playbook 改动
- 小范围试点

### 在 Claude Code 中的推荐使用方式

插件接入后，建议直接在项目中按自然语言使用框架，例如：

```text
先不要写代码，帮我讨论这个需求方案。
```

```text
按当前框架走 brainstorming -> writing-plans -> execution。
```

```text
最后给我一份 Compound Candidates。
```

---

## 使用方法

框架的核心使用方式有两种：
1. 接入现有项目
2. 用于新项目启动

---

## 一、现有项目接入方法

适合场景：
- 已有代码库
- 已有工程约束
- 已有历史坑点和项目经验
- 想逐步引入这套 agent workflow

### 推荐接入步骤

#### 1. 安装 / 接入本 fork
让你的 agent 使用这个 fork 的 skills 和说明。

#### 2. 先建立 project playbook
优先整理当前项目最重要的 repo-specific knowledge：

```text
docs/project-playbook/
  README.md
  index.md
  pitfalls.md
  patterns.md
  legacy-constraints.md
```

建议先整理：
- 10~20 条高价值坑点
- 历史遗留限制
- 重复踩坑的集成问题
- 项目验证过的有效模式

#### 3. 再建立 company standards 的相关 domain corpus
如果项目先从 frontend 开始，就先补：

```text
docs/company-standards/frontend/
```

如果项目是后端为主，就先补：

```text
docs/company-standards/backend/
```

如果存在跨域规则，就补：

```text
docs/company-standards/shared/
```

#### 4. 先选一个真实 feature 做试点
不要一上来全项目切换。

先找一个真实需求，按以下流程走一轮：
- brainstorming
- writing-plans
- subagent-driven-development
- compound-engineering

在这个 feature 里验证：
- standards IDs 是否足够清晰
- project-note excerpts 是否足够实用
- task packets 是否能有效减少上下文污染

#### 5. 用 compound step 逐步反哺知识库
每次做完一个真实任务，不要只停在“功能完成”。

还要判断：
- 哪些经验属于 company standards
- 哪些经验只属于 project playbook
- 哪些只是 feature-specific

这样框架会越用越强。

### 现有项目接入的最小落地版本

如果你不想一次性做太多，建议最低配这样开始：

```text
docs/company-standards/frontend/index.md
docs/project-playbook/index.md
```

然后先补最常用的：
- 5~10 条 standards
- 5~10 条 project notes

等 workflow 真的跑通，再继续扩展。

---

## 二、新项目接入方法

适合场景：
- 新系统
- 新业务线
- 新仓库
- 想从一开始就用统一 workflow 驱动

### 推荐接入步骤

#### 1. 初始化目录结构
至少建立：

```text
docs/company-standards/
  README.md
  index.md
  frontend/
  backend/
  shared/

docs/project-playbook/
  README.md
  index.md

docs/superpowers/specs/
docs/superpowers/plans/
```

#### 2. 选择首批 domain corpus
根据项目类型选择：

- 前端项目：先补 `frontend/`
- 后端项目：先补 `backend/`
- 全栈项目：补 `frontend/` + `backend/` + `shared/`

#### 3. 建立首批 seed rules
建议不要贪多。

##### frontend 首批建议
- `FE-COMP-*`
- `FE-HOOK-*`
- `FE-TEST-*`

##### backend 首批建议
- `BE-API-*`
- `BE-SVC-*`
- `BE-TEST-*`

##### shared 首批建议
- `SH-TEST-*`
- `SH-ARCH-*`
- `SH-SEC-*`

#### 4. 建立最小 project playbook
即使是新项目，也建议从一开始就有：

```text
docs/project-playbook/index.md
```

因为新项目很快也会出现：
- 本项目自己的坑
- 本项目自己的决策
- 本项目自己的 workaround

#### 5. 所有需求都走同一条链路
推荐统一流程：
- brainstorming
- writing-plans
- subagent-driven-development
- compound-engineering

这会让项目从一开始就具有：
- 设计清晰度
- 执行一致性
- 经验沉淀能力

---

## standards 与 project playbook 的放置原则

### 放到 company standards，如果：
- 跨多个项目适用
- 是长期规则
- 是公司级工程约束或最佳实践

### 放到 project playbook，如果：
- 只在当前项目成立
- 与当前仓库的架构、依赖、legacy 有关
- 离开这个项目后不一定成立

### 放到 feature spec / plan，如果：
- 只对当前 feature 有效
- 生命周期很短
- 不值得长期沉淀

---

## 当前版本的限制与后续演进

### 当前 v1
- 默认使用 repo-local corpora
- 已支持 frontend/backend/shared + project playbook
- 已支持 progressive disclosure task packets
- 已支持 compound step

### 后续 v2 / v3 可以继续做
- private overlay corpora（方案 C）
- corpus resolver（env/local config/fallback）
- 自动从 corpus 解析 applicable IDs
- 更强的多域示例与模板

---

## 推荐使用顺序

如果你今天就要开始用：

### 对现有项目
1. 先建 `project-playbook`
2. 再补相关 domain standards
3. 选一个真实 feature 试跑
4. 用 compound step 反哺知识库

### 对新项目
1. 先建 `company-standards` + `project-playbook` 基础结构
2. 先补少量 seed rules
3. 从第一个 feature 起就用统一 workflow

---

## 当前最重要的原则

这套框架的核心不是“多写文档”，而是让文档真正进入 agent workflow：
- standards 进入 spec
- spec 进入 plan
- plan 进入 task packet
- task packet 进入 subagent prompt
- 经验再回流到 standards / playbook

也就是说，这是一套：
**知识可引用、可执行、可复利的工程工作流框架。**
