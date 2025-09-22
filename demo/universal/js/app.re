type user = {
  id: int,
  name: string,
  email: string,
  avatar: string,
  status: string,
};

let mockUsers = [|
  {
    id: 1,
    name: "Alice Johnson",
    email: "alice@example.com",
    avatar: "🦊",
    status: "online",
  },
  {
    id: 2,
    name: "Bob Smith",
    email: "bob@example.com",
    avatar: "🐻",
    status: "offline",
  },
  {
    id: 3,
    name: "Charlie Brown",
    email: "charlie@example.com",
    avatar: "🦁",
    status: "online",
  },
  {
    id: 4,
    name: "Diana Prince",
    email: "diana@example.com",
    avatar: "🦋",
    status: "away",
  },
|];

let container = [%cx2
  {|
  max-width: 1200px;
  margin: 0 auto;
  padding: 2rem;
|}
];

let card = [%cx2
  {|
  background: white;
  border-radius: 16px;
  padding: 2rem;
  margin-bottom: 2rem;
  border: 1px solid #e5e7eb;
|}
];

let header = [%cx2
  {|
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  padding: 2rem;
  text-align: center;
  margin: -2rem -2rem 2rem -2rem;
  border-top-left-radius: 16px;
  border-top-right-radius: 16px;
|}
];

let title = [%cx2
  {|
  font-size: 2rem;
  margin-bottom: 0.5rem;
  color: white;
|}
];

let subtitle = [%cx2
  {|
  opacity: 0.9;
  font-size: 1.1rem;
  color: white;
|}
];

/* Section title */
let sectionTitle = [%cx2
  {|
  font-size: 1.5rem;
  font-weight: 700;
  color: #1f2937;
  margin-bottom: 1rem;
  text-align: center;
|}
];

/* User grid layout */
let userGrid = [%cx2
  {|
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
  gap: 1.5rem;
  margin-bottom: 2rem;
|}
];

/* User card */
let userCardBase = [%cx2
  {|
  background: white;
  border: 2px solid #e5e7eb;
  border-radius: 12px;
  padding: 1.5rem;
  cursor: pointer;
  transition: all 0.2s ease;
  position: relative;
|}
];

let userCardSelected = [%cx2
  {|
  background: #f0f9ff;
  border: 2px solid #3b82f6;
  border-radius: 12px;
  padding: 1.5rem;
  cursor: pointer;
  transition: all 0.2s ease;
  position: relative;
|}
];

let avatar = [%cx2
  {|
  font-size: 3rem;
  text-align: center;
  margin-bottom: 1rem;
|}
];

let userName = [%cx2
  {|
  font-size: 1.25rem;
  font-weight: 600;
  color: #1f2937;
  margin-bottom: 0.5rem;
|}
];

let userEmail = [%cx2 {|
  color: #6b7280;
  font-size: 0.9rem;
|}];

/* Status indicator base */
let statusIndicator = [%cx2
  {|
  position: absolute;
  top: 1rem;
  right: 1rem;
  width: 12px;
  height: 12px;
  border-radius: 50%;
  border: 2px solid white;
  background: #6b7280;
|}
];

let statusOnline = [%cx2 {|
  background: #10b981;
|}];

let statusOffline = [%cx2 {|
  background: #ef4444;
|}];

let statusAway = [%cx2 {|
  background: #f59e0b;
|}];

let buttonPrimary = [%cx2
  {|
  background: #3b82f6;
  color: white;
  border: none;
  padding: 0.75rem 1.5rem;
  border-radius: 8px;
  font-size: 1rem;
  font-weight: 500;
  cursor: pointer;
  margin: 0 0.5rem;
  transition: all 0.2s ease;
|}
];

let buttonSecondary = [%cx2
  {|
  background: #6b7280;
  color: white;
  border: none;
  padding: 0.75rem 1.5rem;
  border-radius: 8px;
  font-size: 1rem;
  font-weight: 500;
  cursor: pointer;
  margin: 0 0.5rem;
  transition: all 0.2s ease;
|}
];

let badge = [%cx2
  {|
  display: inline-block;
  padding: 0.25rem 0.75rem;
  background: #10b981;
  color: white;
  border-radius: 9999px;
  font-size: 0.75rem;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  margin-left: 1rem;
|}
];

let searchInput = [%cx2
  {|
  width: 100%;
  padding: 1rem;
  border: 2px solid #e5e7eb;
  border-radius: 8px;
  font-size: 1rem;
  margin-bottom: 1.5rem;
  transition: all 0.2s ease;
|}
];

/* Stats bar */
let statsBar = [%cx2
  {|
  display: flex;
  justify-content: space-around;
  background: #f3f4f6;
  border-radius: 8px;
  padding: 1rem;
  margin: 2rem 0;
|}
];

/* Stat item */
let statItem = [%cx2 {|
  text-align: center;
|}];

let statValue = [%cx2
  {|
  font-size: 2rem;
  font-weight: bold;
  color: #1f2937;
|}
];

let statLabel = [%cx2
  {|
  font-size: 0.9rem;
  color: #6b7280;
  margin-top: 0.25rem;
|}
];

/* Selected user info */
let selectedInfo = [%cx2
  {|
  padding: 1rem;
  background: #f0f9ff;
  border-radius: 8px;
  text-align: center;
  font-size: 1.1rem;
  color: #1f2937;
|}
];

let buttonContainer = [%cx2
  {|
  margin-bottom: 1rem;
  text-align: center;
|}
];

/* UserCard component */
module UserCard = {
  [@react.component]
  let make = (~user, ~isSelected, ~onClick) => {
    let cardStyles = isSelected ? userCardSelected : userCardBase;
    let statusStyles =
      switch (user.status) {
      | "online" => statusOnline
      | "offline" => statusOffline
      | "away" => statusAway
      | _ => statusIndicator
      };

    <div styles=cardStyles onClick>
      <div styles=avatar> {React.string(user.avatar)} </div>
      <div styles=userName> {React.string(user.name)} </div>
      <div styles=userEmail> {React.string(user.email)} </div>
      <div styles=statusStyles />
    </div>;
  };
};

/* Main App Component */
[@react.component]
let make = () => {
  let (selectedUserId, setSelectedUserId) = React.useState(() => None);
  let (searchTerm, setSearchTerm) = React.useState(() => "");
  let (showStats, setShowStats) = React.useState(() => true);

  let filteredUsers =
    mockUsers
    |> Array.to_list
    |> List.filter(user => {
         searchTerm == ""
         || Js.String.includes(
              ~search=Js.String.toLowerCase(searchTerm),
              Js.String.toLowerCase(user.name),
            )
         || Js.String.includes(
              ~search=Js.String.toLowerCase(searchTerm),
              Js.String.toLowerCase(user.email),
            )
       })
    |> Array.of_list;

  let onlineCount =
    mockUsers
    |> Array.to_list
    |> List.filter(u => u.status == "online")
    |> List.length;
  let totalCount = Array.length(mockUsers);

  <div styles=container>
    <div styles=card>
      <div styles=header>
        <h1 styles=title> {React.string("🎨 styled-ppx Demo")} </h1>
        <p styles=subtitle>
          {React.string("Showcasing CSS-in-Reason with styled-ppx")}
        </p>
      </div>
      <h2 styles=sectionTitle> {React.string("User Directory")} </h2>
      <input
        type_="text"
        styles=searchInput
        placeholder="Search users by name or email..."
        value=searchTerm
        onChange={e => {
          let target = React.Event.Form.target(e);
          let value = target##value;
          setSearchTerm(_ => value);
        }}
      />
      <div styles=buttonContainer>
        <button
          styles=buttonPrimary onClick={_ => setShowStats(prev => !prev)}>
          {React.string(showStats ? "Hide Stats" : "Show Stats")}
        </button>
        <button
          styles=buttonSecondary onClick={_ => setSelectedUserId(_ => None)}>
          {React.string("Clear Selection")}
        </button>
        <span styles=badge>
          {React.string(string_of_int(onlineCount) ++ " Online")}
        </span>
      </div>
      {showStats
         ? <div styles=statsBar>
             <div styles=statItem>
               <div styles=statValue>
                 {React.string(string_of_int(totalCount))}
               </div>
               <div styles=statLabel> {React.string("Total Users")} </div>
             </div>
             <div styles=statItem>
               <div styles=statValue>
                 {React.string(string_of_int(onlineCount))}
               </div>
               <div styles=statLabel> {React.string("Online")} </div>
             </div>
             <div styles=statItem>
               <div styles=statValue>
                 {React.string(string_of_int(Array.length(filteredUsers)))}
               </div>
               <div styles=statLabel> {React.string("Filtered")} </div>
             </div>
           </div>
         : React.null}
      <div styles=userGrid>
        {filteredUsers
         |> Array.map(user =>
              <UserCard
                key={string_of_int(user.id)}
                user
                isSelected={Some(user.id) == selectedUserId}
                onClick={_ => setSelectedUserId(_ => Some(user.id))}
              />
            )
         |> React.array}
      </div>
      {selectedUserId != None
         ? <div styles=selectedInfo>
             {switch (selectedUserId) {
              | Some(id) =>
                switch (
                  mockUsers |> Array.to_list |> List.find_opt(u => u.id == id)
                ) {
                | Some(user) =>
                  React.string(
                    "Selected: " ++ user.name ++ " (" ++ user.email ++ ")",
                  )
                | None => React.null
                }
              | None => React.null
              }}
           </div>
         : React.null}
    </div>
  </div>;
};
