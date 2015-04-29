from pyramid.view import view_config, view_defaults

from ..models import DBSession, Part, Package

from .base import BaseView

from ..utils.pagination import Pagination

@view_defaults(request_method='GET')
class ListView(BaseView):

    @property
    def nav_active(self):
        """ Currently active navigation entry has the same name as our route.
        """
        return self.request.matched_route.name

    def serve(self, query):
        pagination = Pagination(query, self.request)
        return {'pagination': pagination}
        
class ListView(ListView):

    @view_config(
        route_name='list_parts',
        renderer='particledb:templates/list_parts.mak')
    def list_parts(self):
        return self.serve(DBSession.query(Part))

    @view_config(
        route_name='list_packages',
        renderer='particledb:templates/list_packages.mak')
    def list_packages(self):
        return self.serve(DBSession.query(Package))
