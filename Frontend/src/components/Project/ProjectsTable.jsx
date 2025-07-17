

export default function ProjectsTable({ projects }) {
  return <>
    <h1>Projects</h1>
    <table className='table table-bordered bg-dark text-white'>
      <thead>
        <tr>
          <th>Name</th>
          <th>Start Date</th>
          <th>Duration</th>
          <th>View</th>
        </tr>
      </thead>
      <tbody>
        {
          projects.map(project => {
            return <Project {...project} key={project.id} />
          })
        }
      </tbody>
    </table>
  </>
}