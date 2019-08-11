function cache = addcache(cache,hashkey,input)

if ~iscell(input)
input = {input};
end

%Hard-coded limit to all function's caches
cachelimiter = 20;

for i=1:length(input)
    if isstruct(input{i})
        MatlabStruct = input{i};
        fields = fieldnames(MatlabStruct);
        JavaStructure =  java.util.Hashtable;
        for j=1:length(fields)
            JavaStructure.put(fields{j},getfield(MatlabStruct,fields{j}));
        end
        input{i} = JavaStructure;
    end
end
%Check if current cache exceeds the number of cached states
if cache.size > cachelimiter
    
    %If so, get the hash table keys...
    keys = cache.keySet;
    keys = cell(keys.toArray);
    %... and remove the oldest cache entry 
    cache.remove(keys{end});
end

%Then add the new cache entry
cache.put(hashkey,input);


end