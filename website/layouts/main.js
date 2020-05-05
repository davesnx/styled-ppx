export default ({ children }) => {
  return (
    <html>
      <body>
        <div>
          {children}
          <div className="p-4 shadow rounded bg-white">
            <h1 className="text-purple leading-normal">Next.js</h1>
            <p className="text-grey-dark">with Tailwind CSS</p>
          </div>
        </div>
      </body>
    </html>
  );
};
