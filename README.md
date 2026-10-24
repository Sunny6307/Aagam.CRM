# AAGAM Stainless CRM — Cloud Starter

This is a responsive browser-based starter for a shared, multi-user customer and daily-calling CRM.

## Included
- Customer master: party, contact, address, state, email, phone, item, grade, sizes, current supplier
- Daily call logging, call status, interest, quotation, follow-up date, next action, caller, remarks
- Dashboard counters and due follow-ups
- CSV exports for Excel
- Supabase email/password authentication and shared cloud database
- Click-to-call via `tel:` links (subject to the device/browser)

## Important status
This is a starter project, **not a deployed live service**. It becomes cloud-enabled only after you create/configure a Supabase project and host the files on a web host. No accounts, hosting, or call-log permissions have been provisioned.

## Setup (admin/developer)
1. Create a Supabase project at https://supabase.com/.
2. In Supabase SQL Editor, run all of `schema.sql`.
3. In Project Settings → API, copy the **Project URL** and the **publishable/anon public key**.
4. Open `index.html` and replace:
   - `PASTE_YOUR_SUPABASE_PROJECT_URL_HERE`
   - `PASTE_YOUR_SUPABASE_ANON_KEY_HERE`
   Never put the `service_role` secret in browser code.
5. Host `index.html` over HTTPS using a static host (for example, Netlify, Vercel, or your company's web hosting). Configure Supabase Auth redirect URLs for the hosted domain.
6. Create team users in Supabase Authentication. For production, disable public self-sign-up after creating users if only approved staff should access the CRM.
7. Test with two separate user accounts and confirm shared records, editing, reports, and backups before adding live business data.

## Team access / security notes
The included policies allow authenticated team members to view and edit shared CRM records. This is a basic shared-team policy, not a finished role/assignment system. Before production use, add an admin/team-member role table and restrict delete/update permissions if needed. Enable MFA if available, keep staff access reviewed, and establish a data-retention/backup plan.

## Phone calling and call-log integration
- `tel:` links open the phone dialer when supported; a browser cannot silently place calls or read the device's cellular call history.
- Android automatic call-log import requires a separate native Android app and explicit runtime permission (such as `READ_CALL_LOG`), plus Google Play policy and privacy review. A web app alone cannot do it.
- iOS does not provide ordinary apps general access to the user's cellular call history. For iPhone users, use manual call outcome logging or an approved telephony/VoIP provider that supplies call events through its API/webhooks.
- Do not collect call logs without clear notice, valid consent, and appropriate business/legal approval.

## Suggested next production steps
1. Admin/member roles and lead assignment.
2. Duplicate customer detection by normalized phone number.
3. Audit log and soft-delete.
4. CSV import with preview and duplicate handling.
5. Cloud backups and recovery tests.
6. Android companion app or telephony provider integration after choosing the supported calling workflow.
