# Where I Left Off

This file is prepared to quickly track the remaining work on the Flutter side.

## Current Status

- The auth flow works, but there are still issues in some follow-up screen transitions.
- The user state after the avatar page needs to be checked again.
- The domain requirement for email-related flows needs to be clarified.

## Todo

- [ ] Investigate the "user not found" error shown after a successful login on the avatar page.
- [ ] Identify which API call or local cache check fails after a successful login.
- [ ] Verify the user/profile flow after the avatar screen.
- [ ] Note that email sending or email-based flows may require a domain and clarify the service dependency.
- [ ] If a domain is required, define the provider, cost, and technical setup steps.

## Priority Topics

### 1. Avatar Page Error

Issue:
After a successful login, the system shows a "user not found" error.

Things to check:

- Is the user id/token returned after login stored correctly?
- Does the profile fetch request after the avatar page call the correct endpoint?
- Is there any mismatch between local cache data and backend data?

### 2. Domain Requirement for Email

Note:
A domain may be required for sending emails.

Things to check:

- Does the email service in use require domain verification?
- Is only a sender address needed, or is full domain authentication required?
- Will DNS records such as SPF, DKIM, and DMARC be required?

## Next Step

First, find the root cause of the error on the avatar page.
Then clarify the technical requirement for email/domain setup.
