type user = {
  id: int,
  name: string,
  email: string,
  avatar: string,
  status: string,
};

let mockUsers = [
  {
    id: 1,
    name: "Alice Johnson",
    email: "alice@example.com",
    avatar: {js|🦊|js},
    status: "online",
  },
  {
    id: 2,
    name: "Bob Smith",
    email: "bob@example.com",
    avatar: {js|🐻|js},
    status: "offline",
  },
  {
    id: 3,
    name: "Charlie Brown",
    email: "charlie@example.com",
    avatar: {js|🦁|js},
    status: "online",
  },
  {
    id: 4,
    name: "Diana Prince",
    email: "diana@example.com",
    avatar: {js|🦋|js},
    status: "away",
  },
];

let container = [%cx2
  {|
  max-width: 1200px;
  margin: 0 auto;
  padding: 2rem;
  box-shadow: 0 0 10px 0 rgba(0, 0, 0, 0.1);
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

let userGrid = [%cx2
  {|
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
  gap: 1.5rem;
  margin-bottom: 2rem;
|}
];

let userCardBase = [%cx2
  {|
  user-select: none;
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
  user-select: none;
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
  position: relative;
|}
];

let arrowLink = [%cx2
  {|
  color: #3b82f6;
  text-decoration: none;
  position: relative;
  padding-left: 1.5rem;
  display: inline-block;

  &::before {
    content: "→";
    position: absolute;
    left: 0;
    transition: transform 0.2s ease;
  }

  &:hover::before {
    transform: translateX(4px);
  }
|}
];

let quotedText = [%cx2
  {|
  font-style: italic;
  color: #4b5563;
  position: relative;
  padding: 0 0.5rem;
  display: block;

  &::before {
    content: "“";
    font-size: 1.5em;
    color: #9ca3af;
    position: absolute;
    left: -0.5rem;
    top: -0.25rem;
  }

  &::after {
    content: "“";
    font-size: 1.5em;
    color: #9ca3af;
    position: absolute;
    right: -0.5rem;
    bottom: -0.25rem;
  }
|}
];

let tooltipElement = [%cx2
  {|
  position: relative;
  cursor: help;
  text-decoration: underline;
  text-decoration-style: dotted;
  text-underline-offset: 2px;

  &::after {
    content: "This is a tooltip example";
    position: absolute;
    bottom: 100%;
    left: 50%;
    transform: translateX(-50%);
    background: #1f2937;
    color: white;
    padding: 0.5rem 0.75rem;
    border-radius: 6px;
    font-size: 0.875rem;
    white-space: nowrap;
    opacity: 0;
    pointer-events: none;
    transition: opacity 0.2s ease;
    margin-bottom: 0.5rem;
  }

  &:hover::after {
    opacity: 1;
  }
|}
];

let listWithCustomBullets = [%cx2
  {|
  list-style: none;
  padding-left: 1.5rem;

  li::before {
    content: "✦";
    color: #3b82f6;
    font-weight: bold;
    margin-right: 0.5rem;
    margin-left: -1.5rem;
  }
|}
];

let numberedList = [%cx2
  {|
  counter-reset: item-counter;
  list-style: none;
  padding-left: 2rem;

  li {
    counter-increment: item-counter;
    position: relative;
    margin-bottom: 0.5rem;
  }

  li::before {
    content: counter(item-counter, decimal-leading-zero);
    position: absolute;
    left: -2rem;
    background: #3b82f6;
    color: white;
    width: 1.5rem;
    height: 1.5rem;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 0.75rem;
    font-weight: bold;
  }
|}
];

let contentExamplesSection = [%cx2
  {|
  background: #f9fafb;
  border: 1px solid #e5e7eb;
  border-radius: 8px;
  padding: 1.5rem;
  margin-bottom: 2rem;
|}
];

/* Small heading for examples */
let exampleHeading = [%cx2
  {|
  font-size: 1.125rem;
  font-weight: 600;
  color: #374151;
  margin-bottom: 1rem;
  display: flex;
  align-items: center;

  &::before {
    content: "💡";
    margin-right: 0.5rem;
    font-size: 1.25rem;
  }
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
  margin-bottom: 2rem;
  text-align: center;
|}
];

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
       });

  let onlineCount =
    mockUsers |> List.filter(u => u.status == "online") |> List.length;
  let totalCount = List.length(mockUsers);

  <div styles=container>
    <div styles=card>
      <div styles=header>
        <h1 styles=title> {React.string({js|🎨 styled-ppx Demo|js})} </h1>
        <p styles=subtitle>
          {React.string("Showcasing CSS-in-Reason with styled-ppx")}
        </p>
      </div>
      <div styles=contentExamplesSection>
        <h3 styles=exampleHeading>
          {React.string("EMOJI on content property")}
        </h3>
        <p styles=quotedText>
          {React.string(
             "This demonstrates the content property with quotation marks",
           )}
        </p>
        <a
          href="#"
          styles=arrowLink
          onClick={e => React.Event.Mouse.preventDefault(e)}>
          {React.string("Hover me to see the arrow animation")}
        </a>
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
                   {React.int(List.length(filteredUsers))}
                 </div>
                 <div styles=statLabel> {React.string("Filtered")} </div>
               </div>
             </div>
           : React.null}
        <div styles=userGrid>
          {filteredUsers
           |> List.map(user =>
                <UserCard
                  key={string_of_int(user.id)}
                  user
                  isSelected={Some(user.id) == selectedUserId}
                  onClick={_ => setSelectedUserId(_ => Some(user.id))}
                />
              )
           |> Array.of_list
           |> React.array}
        </div>
        {selectedUserId != None
           ? <div styles=selectedInfo>
               {switch (selectedUserId) {
                | Some(id) =>
                  switch (mockUsers |> List.find_opt(u => u.id == id)) {
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
    </div>
  </div>;
};
