import os

# Bootstrap the Sentry environment
from sentry.utils.runner import configure
configure()

# Then import the models
from sentry.models import (
    Team, Project, User, Organization, OrganizationMember,
    OrganizationMemberTeam
)

# Create an organization, team, and user if there are *no* users
# in the install (bootstrap 1 time only)
if not User.objects.all():
    organization = Organization()
    organization.name = os.environ.get('TEAM_NAME', 'Aptible')
    organization.save()

    team = Team()
    team.name = os.environ.get('TEAM_NAME', 'Aptible')
    team.organization = organization
    team.save()

    project = Project()
    project.team = team
    project.name = 'Default'
    project.organization = organization
    project.save()

    user = User()
    user.username = os.environ.get('ADMIN_USERNAME', 'aptible')
    user.email = 'admin@localhost'
    user.is_superuser = True
    user.set_password(os.environ['ADMIN_PASSWORD'])
    user.save()

    member = OrganizationMember.objects.create(
        organization=organization,
        user=user,
        role='owner',
    )

    OrganizationMemberTeam.objects.create(
        organizationmember=member,
        team=team,
    )
