module ProjectsHelper
  def projects_select_tag(f)
    f.collection_select(:project_id, Project.order(:category, :code).where(completed: false).all, :id, :code_and_name, {} ,{:class => "form-control"})
  end
end
