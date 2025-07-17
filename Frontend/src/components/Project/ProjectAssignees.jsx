

export default function ProjectAssignees({ projectId, users, removeUserFromProject }) {
  console.log(users);
  if(users.length == 0) {
    return <p>No Users Assigned Yet</p>
  }

  return <div>
    <h2>Users</h2>
    <div className="d-flex gap-3 mb-2">
      {
        users.map(user => {
          return <button key={user.id} type="button" className="btn btn-sm btn-default border">
            {user.name} <span className="badge" onClick={() => removeUserFromProject(projectId, user.id)}>❌</span>
          </button>
        })
      }
    </div>
  </div>
}