WINDSURF FEDRAMP DEMO GUIDE FOR PERATON
=======================================
Prepared for: Jake Cosme
Demo Audience: Peraton DHS DECO Service Delivery Managers & Engineers

DEMO OVERVIEW
-------------
This folder contains 6 plain text requirement/runbook files designed to 
showcase Windsurf FedRAMP's ability to convert manual documentation into 
Infrastructure as Code (Terraform) and automation scripts (Ansible/PowerShell).

These files mirror the patterns in the existing DHS-CISA-cool-accounts 
codebase and address Peraton's specific pain points:
- Manual IaaC template editing
- Click-off procedures
- Archaic change management (manual docs -> ServiceNow -> execution)

FILES INCLUDED
--------------
TERRAFORM DEMOS (IaaC Generation):
1. 01-terraform-new-service-account.txt
   - Converts manual service account provisioning spec to Terraform
   - Shows: IAM roles, SNS topics, EventBridge rules, Lambda integration
   - Complexity: High (multiple interconnected resources)

2. 02-terraform-security-role.txt
   - Converts security role requirements to Terraform
   - Shows: IAM policies, cross-account roles, MFA conditions
   - Complexity: Medium (policy documents, role assumptions)

3. 03-terraform-compliance-group.txt
   - Converts compliance auditor group spec to Terraform
   - Shows: IAM groups, policy attachments, group memberships
   - Complexity: Medium (follows existing gods_group.tf pattern)

ANSIBLE/POWERSHELL DEMOS (Automation from Runbooks):
4. 04-ansible-user-offboarding.txt
   - Converts manual user offboarding runbook to Ansible playbook
   - Shows: Click-off replacement, multi-step automation
   - Complexity: High (7 manual steps -> automated workflow)

5. 05-ansible-compliance-check.txt
   - Converts weekly compliance audit runbook to Ansible playbook
   - Shows: Automated compliance checking, report generation
   - Complexity: High (8 manual checks -> automated audit)

6. 06-powershell-servicenow-sync.txt
   - Converts manual ServiceNow sync procedure to PowerShell
   - Shows: AWS-to-ServiceNow integration, change tracking
   - Complexity: High (bridges documentation and execution gap)

DEMO EXECUTION TO-DO LIST
-------------------------

BEFORE THE DEMO:
[ ] Open Windsurf FedRAMP with DHS-CISA-cool-accounts repo indexed
[ ] Have this demo-requirements folder visible
[ ] Open a few existing .tf files for reference (users/gods_group.tf, dynamic/ec2readonly_role.tf)
[ ] Prepare to show the "before" (manual doc) and "after" (generated code)

DEMO FLOW (Recommended Order):

1. OPENING (2-3 min)
   [ ] Briefly mention FedRAMP Moderate authorization
   [ ] Explain: "I'm going to show you how to turn manual documentation 
       into production-ready Infrastructure as Code"

2. TERRAFORM DEMO - Security Role (10-12 min)
   [ ] Open 02-terraform-security-role.txt
   [ ] Highlight: "This is a typical manual spec your team might write"
   [ ] In Windsurf, prompt: "Convert this security role specification 
       into Terraform code following the patterns in dynamic/ec2readonly_role.tf"
   [ ] Show generated code
   [ ] Point out: dependency detection, best practices, security patterns
   [ ] Optional: Ask Windsurf to explain the generated code

3. TERRAFORM DEMO - Compliance Group (8-10 min)
   [ ] Open 03-terraform-compliance-group.txt
   [ ] In Windsurf, prompt: "Convert this compliance auditor group 
       specification into Terraform following users/gods_group.tf patterns"
   [ ] Show how it matches existing codebase conventions
   [ ] Highlight: consistent naming, proper variable usage

4. ANSIBLE DEMO - User Offboarding (10-12 min)
   [ ] Open 04-ansible-user-offboarding.txt
   [ ] Say: "This is a 45-minute manual click-off procedure"
   [ ] In Windsurf, prompt: "Convert this user offboarding runbook into 
       an Ansible playbook with proper error handling and logging"
   [ ] Show generated playbook
   [ ] Highlight: idempotency, error handling, audit logging
   [ ] Point out: "What took 45 minutes of clicking now runs in seconds"

5. POWERSHELL DEMO - ServiceNow Sync (5-7 min)
   [ ] Open 06-powershell-servicenow-sync.txt
   [ ] Say: "This bridges the gap between AWS and ServiceNow"
   [ ] In Windsurf, prompt: "Convert this ServiceNow sync procedure into 
       a PowerShell script using AWS Tools for PowerShell"
   [ ] Show generated script
   [ ] Highlight: API integration, change detection, reporting

6. CLOSING (3-5 min)
   [ ] Summarize: "Manual documentation -> executable code"
   [ ] Emphasize: Human review still required before deployment
   [ ] Mention: FedRAMP compliant, can run in your cloud environment

SUGGESTED PROMPTS FOR WINDSURF
------------------------------

For Terraform generation:
"Convert this specification into Terraform code following the patterns 
in [reference file]. Include proper variables, outputs, and documentation."

For Ansible generation:
"Convert this manual runbook into an Ansible playbook using the amazon.aws 
collection. Include error handling, idempotency, and generate a summary report."

For PowerShell generation:
"Convert this procedure into a PowerShell script using AWS Tools for 
PowerShell. Include proper error handling, logging, and credential management."

For code review:
"Review this Terraform code and identify any security issues, missing 
dependencies, or improvements based on AWS best practices."

KEY TALKING POINTS
------------------
1. "Accelerate, don't replace" - AI assists engineers, doesn't replace them
2. "From manual to automated" - Bridge click-offs to code
3. "Compliance built-in" - FedRAMP Moderate, self-hosted option
4. "Quality at speed" - First-pass review before human review
5. "Consistent patterns" - Follows existing codebase conventions

AUDIENCE-SPECIFIC NOTES
-----------------------
- Service delivery managers: Focus on time savings and consistency
- PowerShell/Ansible engineers: Show the generated code quality
- Cloud IaaC engineers: Highlight Terraform patterns and best practices
- SaaS admins: Emphasize click-off replacement scenarios

Remember: This audience is unfamiliar with modern IDE approaches, so 
keep prompts simple and in natural language. Avoid developer jargon.
