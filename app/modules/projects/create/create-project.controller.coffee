###
# Copyright (C) 2014-2016 Taiga Agile LLC <taiga@taiga.io>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#
# File: project.controller.coffee
###

class CreateProjectController
    @.$inject = [
        "tgAppMetaService",
        "$translate",
        "tgProjectService",
        "$location"
    ]

    constructor: (@appMetaService, @translate, @projectService, @location) ->
        taiga.defineImmutableProperty @, "project", () => return @projectService.project

        @appMetaService.setfn @._setMeta.bind(this)

        @.displayScrumDesc = false
        @.displayKanbanDesc = false
        @.step = "home"

        if @location.search().from == "trello" or @location.search().from == "jira"
            @.step = "import"

    _setMeta: () ->
        return null if !@.project

        ctx = {projectName: @.project.get("name")}

        return {
            title: @translate.instant("PROJECT.PAGE_TITLE", ctx)
            description: @.project.get("description")
        }

angular.module("taigaProjects").controller("CreateProjectCtrl", CreateProjectController)
