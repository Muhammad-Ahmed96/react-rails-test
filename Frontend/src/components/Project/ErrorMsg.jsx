

export default function ErrorMsg({ msg }) {
  return <div className="alert alert-danger alert-dismissible fade show" role="alert">
    {msg}
    <button type="button" className="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
}